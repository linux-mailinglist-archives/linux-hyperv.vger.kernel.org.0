Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA05A42B2B2
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Oct 2021 04:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbhJMCfd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Oct 2021 22:35:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1222 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236225AbhJMCfc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Oct 2021 22:35:32 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D0eT79010782;
        Wed, 13 Oct 2021 02:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=g1PkkW3J0WnlkIW1ihh5aIq9fxtRxQ8BBexfkwtJr+o=;
 b=OepVqidkBaWQZDDh2L1a1uzgkfU6IRPJ9Ei5cIcYsPU3arEZTIXxJmg97bmi9YZiCtAT
 +jeE9ujsGp8su59tFOLQNQRYrIAiyDcb4PfDySYnqiocjSrvAfTuW/uE2UEo765qTIoQ
 vYHMRFIddbFqhuCna68xi/HaSQZM+3biNFIHf5DMfhKZ+y0GFmZNla/j2DY/SZaeROKZ
 AtJ59u2VL3iXf+/6v682UO2CyUeXxdtGTJBwzftOVzx1KoO6TZfwc/rmaF2Vhbrch4Cn
 j27fcTqnJaSbnLvV3UdKvVQ4ja2wjMetBE0UDNy10RwGB8OFv+F/AwEcupIZqTh/6qDh hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbk8tf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 02:33:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D2Ukl0170197;
        Wed, 13 Oct 2021 02:33:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3020.oracle.com with ESMTP id 3bmae01jmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 02:33:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9ld1fNSaQMChPOWVWQnNuWdcR9dQADssxjqdUDdzoNeR2qVf0IjOkvzldKT9dUokoY0CoeVkxb2wTzT1s684ZSEFL6FxlL0cyTCjJwtGXFezhThSUG356e6F0B+/2qYEvPkwg3oyVcO8NgFB+jFfwhN1nDnqMcHCYE2CIHsBq2G0i2oUiDGWI3Mbhhog77dPnbTkFtt/T9m6W79iLqYLIvceZADgIra7TqfX0W/dKX+zvTlU14+ukiuBx8gJqltQpD/pN96vvL7JtscHceqyavRSFK0UdNe7L1dTQ3mCMCNmz7MimCsSSbNTwVsZqUH13591QrKqG73/xiiLehUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1PkkW3J0WnlkIW1ihh5aIq9fxtRxQ8BBexfkwtJr+o=;
 b=TlnSMf4gtdcjkLiRmj7qD4HsuJkjoEQWLx4geIT+w3syF9/V6kWmSydp+qHNTjm5iEBGfeD81Fp5h3yvksUseU9f5Io0UA+keqaug86BtO8Mu07vGaHg45ZiZ0Qm6P16I77laQwiR6w8HYo2dFuLbJawSmsEVHmbmsvtRDDOTRf10hHpxktOdYf5+A2PsKOCMDlkMWOk2YMcJWui1fDCSVcwP5/UpENLDUO5a/n4WP3BX0Wyb7NWJp2RtruVcbwtC9AMTqNO3nEUyQrtjUucl1/1/L3FU60dpO1dm19iOLx2qTecbCS3uAC6i/1VeTZnQuFIQQNujKrbOM4h7nlpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1PkkW3J0WnlkIW1ihh5aIq9fxtRxQ8BBexfkwtJr+o=;
 b=wNfoa92sNZlJF+UchuthfS5S+Xii6foAISgj80EhhIgkHieZjVUFhYdqwyDYpWzsPess/xJurP79k5QxFtvFcxKKzeyQmDRVBix0FDGFFnCOV3jJwc8wqfqaEZSrIpiHV1Xg20uJUt81nR1n8ZnIb3zGFMKRhqAzb4NENwz0ifk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by MWHPR10MB1422.namprd10.prod.outlook.com (2603:10b6:300:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 02:33:05 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7c3a:acce:d3fc:a654]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7c3a:acce:d3fc:a654%6]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 02:33:05 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3] scsi: storvsc: Fix validation for unsolicited incoming packets
Date:   Tue, 12 Oct 2021 22:33:00 -0400
Message-Id: <163409236447.9881.727122714874344673.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211007122828.469289-1-parri.andrea@gmail.com>
References: <20211007122828.469289-1-parri.andrea@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
Received: from ca-mkp.mkp.ca.oracle.com (138.3.201.9) by SJ0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:33b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.10 via Frontend Transport; Wed, 13 Oct 2021 02:33:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e16340a-60c8-44a0-8a6c-08d98df1c92b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1422:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB14224FBA3FDAF8B9864DC4EB8EB79@MWHPR10MB1422.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lk6sjM0+wkRE891wTR/SMyrcW/syOsjyYxSfV3s0wt+oBewnlz++aII30KnOZYeo5fqzokoLSgWuNXiEOKC6rbAmF+e7wVQDljwfpX+WFkV6eMRy72cptWxLDjGx/tjJ3R6656sYdOBCrkBJwPpLJ1VOuG9dgvIWwfuNdiR87YxoAM/pTY6+syVd8j5EG5X0rG44dPOxpCMeFw2gStRQa6ND23plDVtqnqAVgsi9V3dSXqOUi8/kPs3GkwkkJwYBBAc931YYF+b6spJH18Qvoh3ME9h5xvLms2lPnKkePOiPTY9mq63T/H4TR11TbnUYKnTBQ48g+79jlzX6eOQnFnuv/VeRKdi4Z4BsEK1EfZRR48YMQ3jOZM2E3qf0w+TnUCeADbxTu9Ha66gpvJ8UaznV7uopPyu74vMDK4iQvHnMi6ekq4Xed8d7Xhdj5/ef1tJe5cJJgyB4/PXmeMD/uQhVEwMhapJuOy+qU1iBAAb3pWPOfPAVNlGhI/lKqgwm3ZUMqbgJ172sU0L5NA+MgzSfZug0XbNY/FTZevAFdEMuuXRjngXSM3rIHqIjnBuy1uBJfUaHWH/fIMpHvMAvCkwNp64IP7t0Apqq2tQYwNW8DdguxNwj+5kao5D/mCt7szI2p3XjKG0/2moEYBUFI92b8MxDl/JWdk5evLYPWserYGNFCnL7/No7cE/c4TCG/JYQoTCRFq98Ml+lFbJ7RxKN3Nb/PIMzrgkH6i3eNn5guwls9Wo5tPq2xM0/aYBCVyJnqXYvBKj7kYbp1b1/PULNFyl2t9pgnNFtdZ/BU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(38350700002)(52116002)(7696005)(186003)(966005)(66556008)(38100700002)(54906003)(45080400002)(26005)(4744005)(316002)(7416002)(36756003)(8676002)(86362001)(66476007)(103116003)(6486002)(4326008)(2616005)(508600001)(5660300002)(66946007)(8936002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blM0b2ZNMDl3cm1uN3JacWFvdmR0NWpwbEF3SmpzSU9GSUFpeHlMMVUzaE9z?=
 =?utf-8?B?YlZ1Rkk2ZEV6d1ZZNCtRd1NNZnpmMWptY1pnS0xnb2JTbiswN3pyYzY2dnFZ?=
 =?utf-8?B?ZU1DSmJiaHJwSkdGc2QzeFI0TXcydDhTaXd6c2JoeldOOFd3TVZSaWZ1K3pG?=
 =?utf-8?B?UXJzbnFrcWlmOUVxYW4yblQ0b1FDMU9NV216K29JaEVicFgyVmJGUnBodzda?=
 =?utf-8?B?VTVqOUV0bnQ0VzBla0hsd1JUazhUaTZZaGNrYVRZSjBNTUF1d0VPN1g5a29a?=
 =?utf-8?B?NnRPK25xVS9OaUU3aUQwcTd6bWZ1a1J5anhBQm9jalVhaFZLbDJ2NkIzS2th?=
 =?utf-8?B?UjFpZkdRNStuRi9xbDFEeVVBWUFNbW93MUdWZWNwVysvaXFpRlplc1B5ODdO?=
 =?utf-8?B?N2EyalM0UVJCdGs2VHcxVTk1Qm53cEFFVTM3cmM2akh5aGhXb3l4Y3dLNXBU?=
 =?utf-8?B?OXhLUThzQ0plbFY1aEJrQ281QTViUEtPTE5Rb1ptWDhheXhRV3RoS2lITFJR?=
 =?utf-8?B?dEhwZjFlMU16MEd2dndrTUhZRVlBT0tXaWF1WVBXN1dYWHJ3L2RNbHRKdkM3?=
 =?utf-8?B?U1RGMFAvN1VWYUdiY1N3QWZPd1k1TnZGWWR6c25OR0tKeGlvOVpjZjlLdmpU?=
 =?utf-8?B?c2NIaUN2bVVCTDdGNDFyY080dGU3eFlzbmthNHBQK0l5ZVQ1VXJXdUxENjh2?=
 =?utf-8?B?Z2ttaytXOGJKZWpkZ3NVQkVGbks1eENDT1B3bDRRV2l5OGFXUVhleWpBVGJ0?=
 =?utf-8?B?WCt0RzBNZ0F6c2FWTlBIQjhUQXFvdUY5c2RuYnc1aG1tWEJMSHpNdCtpT2VW?=
 =?utf-8?B?RFovd0l5OWUvcGRiUi9qM3ErWWpObVQ1U05JR3B1a0hDMGtYeDVmVUk3c0pR?=
 =?utf-8?B?THgzVG9CSlpUaVZoRTBqRWY3MVVuUHd2YmlkbC90YndKbUlMekl2LzFkY2U4?=
 =?utf-8?B?QmNCKzgwMmQyNjJmSk1RZFFlaHpWN3FqbXFiM2k0NDM1ME1obTJ5QUFLTGQv?=
 =?utf-8?B?QkdxNnV6VmdLNXNyQ1l5aXNUdXB6eEpObjQrMGJKZlNjcWZFcjIycHhWekpB?=
 =?utf-8?B?NGdDQ3J1dWZJMDJUUUpmSXYwSGxIb3V0Vm81d1ZpVDdTUzJ2TlFVbjVqbTRo?=
 =?utf-8?B?d0dUYldLcDZPOU9pSGVkb3l2UGFaVlViTFFlYkQvdXVOSDh6ZjNGclJsMmN1?=
 =?utf-8?B?Z1RkajBoNk9OcVJUMDcyOFlLUlFqL1NZTnlTVUJaeXNwK2tzSkgxOFNCYXNy?=
 =?utf-8?B?ZXYwL1EyT1ZtMUZJTDFPN1FmdkVYT2oyaXU4ZFR0REt1ZGdHd0s3aEpmZjNy?=
 =?utf-8?B?UkVPYm5MOXlVN1ltS2xQUlhvd1JBU05BUTVKMnpnV3h1Sjk4VUNiOUp4bExz?=
 =?utf-8?B?NUlObXJhUUQ0M1gxeEJHc0s3LzZzdk4rZ1FVL2FDRCtjRDlrcGIzUThIc3Rw?=
 =?utf-8?B?U09Icmp4WDVPajJhU1oxZG5uZlcrRGIxVDVlQktVbGJtTW0zdmxiOTBBUm9R?=
 =?utf-8?B?NlhraDE0SFgvK0F5UEtvYkNaOE1KTjMrR1FpZjBvdGYxNzlGRTFBMmQydzZn?=
 =?utf-8?B?R2M4SU85dUtsTzhyWWladEtQYkRQdGRQb1Fmc1I2cHBrcEsxNWgwYU13WHpV?=
 =?utf-8?B?bzJBTVlwVFY1b3VEVk1vM0NPTTZFbEg1SVMxSks1UGIrdWZpTHRyZy9MeXVX?=
 =?utf-8?B?dTZLTExvcnZEaUZuWXVQb285bnVnOElpRTBmbkhBQ3JTV0NKK2hFeVBSRFFJ?=
 =?utf-8?Q?gXZcZbePysJ7iMGiFA0PdkBzjLhDJlS6eSDphte?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e16340a-60c8-44a0-8a6c-08d98df1c92b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 02:33:05.3186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSoYpHt6PlH0vs2lZRqS8iBxKIWLxIMenQ2oIjVp8cRWQVCq+eEVLuje+UxBcGUhgzIO5JnaXhpTIH0D63lQiDeuQgcD561EZC+EasmUoN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1422
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=843 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130013
X-Proofpoint-GUID: LBM904_qBDPiDfLgBmfQhDRMcbIdhwGU
X-Proofpoint-ORIG-GUID: LBM904_qBDPiDfLgBmfQhDRMcbIdhwGU
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 7 Oct 2021 14:28:28 +0200, Andrea Parri (Microsoft) wrote:

> The validation on the length of incoming packets performed in
> storvsc_on_channel_callback() does not apply to unsolicited
> packets with ID of 0 sent by Hyper-V.  Adjust the validation
> for such unsolicited packets.
> 
> 

Applied to 5.15/scsi-fixes, thanks!

[1/1] scsi: storvsc: Fix validation for unsolicited incoming packets
      https://git.kernel.org/mkp/scsi/c/6fd13d699d24

-- 
Martin K. Petersen	Oracle Linux Engineering
