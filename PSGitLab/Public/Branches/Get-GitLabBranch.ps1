Function Get-GitLabBranch {
    [cmdletbinding(DefaultParameterSetName = 'All')]
    [OutputType('GitLab.Branch')]
    param(
        
        [Parameter(Mandatory = $true)]
        [string]$ProjectId,

        [Parameter(ParameterSetName = 'All')]
        [switch]$All,

        [Parameter(ParameterSetName = 'Branch')]
        [string]$Branch,

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