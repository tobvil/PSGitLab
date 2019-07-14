<#
.Synopsis
    Get-GitLabBranch - Find branches on a specific project
.DESCRIPTION
    Function for finding branches on a specific project. Can return all branches, specific branch, or search for branches by name.
.EXAMPLE
    Get-GitLabBranch -ProjectId 64 -All
.EXAMPLE
    Get-GitLabBranch -ProjectId 64 -Branch Master
.EXAMPLE
    Get-GitLabBranch -ProjectId 64 -Search Test
#>
Function Get-GitLabBranch {
    [cmdletbinding(DefaultParameterSetName = 'All')]
    [OutputType('GitLab.Branch')]
    param(

        #Id of the project
        [Parameter(Mandatory = $true)]
        [string]$ProjectId,

        #Will return all branches associated to project
        [Parameter(ParameterSetName = 'All')]
        [switch]$All,

        #Specify branch name to return specific branch
        [Parameter(ParameterSetName = 'Branch')]
        [string]$Branch,

        #Search for branch
        [Parameter(ParameterSetName = 'Search')]
        [string]$Search
    )

    $Request = @{
        URI    = ''
        Method = 'GET'
    }

    switch ( $PSCmdlet.ParameterSetName) {
        'Branch' { $Request.URI = "/projects/{0}/repository/branches/{1}" -f $ProjectId, $Branch }
        'All' { $Request.URI = "/projects/{0}/repository/branches" -f $ProjectId }
        'Search' { $Request.URI = "/projects/{0}/repository/branches?search={1}" -f $ProjectId, $Search }
    }

    QueryGitLabAPI -Request $Request -ObjectType 'GitLab.Branch'
}