Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8EB3A8ECC
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jun 2021 04:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFPC1X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Jun 2021 22:27:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10660 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230454AbhFPC1X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Jun 2021 22:27:23 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G2GIFQ016728;
        Wed, 16 Jun 2021 02:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=7e1jygg6GyFkhH9ysBkQJT8EKSHPtxLzdlCJP1Y9cNM=;
 b=CITC/5wxoY1NANHrX9EidGXmnvO4WsAJeZIoeqX2DklVBw7ebfv50rNzZlrbMZmSsnEL
 NSzzv+jOZfz2H6EiQIgdYvHiko5YIm2pA+H+935EglUig50gG0fwG+jK1z6lKROk9dhC
 4iEZeyqgeZM4LQlzk/+QWn9mM57QbSLtwmUa97fU6QugStnCgFLXpVAKOSwCF59HWmwX
 MHF0wxqnPftF49Ieel9zK+Uamy9MQMmzIyNDHDZOdr2UEK2w0nBPRmRFkeir4ZOROTCM
 T1UpvcoYgY7aSr1KFzILDvGMMOSpqkAKPksiykFf9Hh4OKnpegv4jS3k7F3vOpgc0W3i vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 395x06hqn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 02:25:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15G2FFg2117718;
        Wed, 16 Jun 2021 02:25:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3030.oracle.com with ESMTP id 396watw6n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 02:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijYxWY8DG4F5deTRrs5JVhUHXH2ecyBQRzQnYl+hbTJnOh1xjG+nDvjx/Qx/YC0/SuusVyIDt8ZnSV6Xgpjlmacwq9IHLl7Ww2yJDA8JOon81YBCDVIQth7xVn73hqYt+9yNNx9lOcJVpJR9x8donsW9IaMvQ0wT7fR1SmFB2tmsbYhb/HSo++oUSqiTh20wxQXf7XX3ZaXPlnk1pbGLutMExtCjyNxQB741Bv3LXnR8o1SFwCdM1rk179zKPRklo/cdbxfRW5Yjqz6BFnxFHrJHFqOus1o1N+9XKf2fhsHTgYO2/OvihHg1DmhaiPfya7+Au+0TlJQIxVr2Q7ewEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e1jygg6GyFkhH9ysBkQJT8EKSHPtxLzdlCJP1Y9cNM=;
 b=a9gnkWS/1FpvFVwtGQaRL5RK5FZOHkxIIhpytkQRPMoZx7PsDP/4E04x2UHa19ezZ17yvfgLH5sf6msA/2JBKMcapekxuZV1awASJxXWmtZLD+Wz4N5GrDyj5QRdlFrkC4N3Z4Mgvr43fykYK9G8ers6VLctgeFKXZg+60+p6/IUsfP2a1lDWmffg6u+xm9wG7KVhKZ4lvAIJj+c4n7BMfGAAnQxU08X/ZzGDWKbw2tegLE/rlGmQGalFKr9CCB0ucd99sB4BMEfKOfTjl+0b4f+myojPPGUInIsFVku4CYvFO5umBV3D4vyN0wzeMpmRsfHe72Q7eqWtEjzuBKEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e1jygg6GyFkhH9ysBkQJT8EKSHPtxLzdlCJP1Y9cNM=;
 b=K6AJVHUmuSsnimjGvjP85QgWVC8JoPU80HY2xoQgK8DJj8/IdZYwELCI2u2vuYTnZt16Hxsj2MP3bbAYevD+621wxCvXwfpc3F/srjcfIs1c6aqz3pX/NgJIdFgjyrtpf4zvYF4zlCswURFVAtVU9qxYhgsnXcMkwO0aI/8Uzo8=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4583.namprd10.prod.outlook.com (2603:10b6:510:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 02:25:12 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::4c61:9532:4af0:8796]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::4c61:9532:4af0:8796%7]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 02:25:12 +0000
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/3] scsi: storvsc: Miscellaneous code cleanups
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135ti7em1.fsf@ca-mkp.ca.oracle.com>
References: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
Date:   Tue, 15 Jun 2021 22:25:09 -0400
In-Reply-To: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
        (Michael Kelley's message of "Fri, 4 Jun 2021 10:21:01 -0700")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: SA9P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SA9P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Wed, 16 Jun 2021 02:25:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db357378-c21b-440e-d967-08d9306df816
X-MS-TrafficTypeDiagnostic: PH0PR10MB4583:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4583C373939B7C9F365210F28E0F9@PH0PR10MB4583.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Fn4gpq1K0Pfv4E6HGyDui/vPzfm3dGmcH47IzpseToQVv3RYCGRuJ90FfvY/tzIyrmEHKLycAu0qzKgOOb9jUTlrQVf/FIjdA2f1QXZE6Tge7i7xxtKOINtrByWDmj1z2QKo264j4LNZ6Vanwu9EZ4NW/slnhap8Zg4yZJY78tUl4MGdHI9g+OJBhpJl4jQHimdAPEFUvu2hf7GaRPrbNYREX4+sCiOtQigD1s5gbDgvpmVG8E/mduVUNrLcLj0EXvtcC3dYUMDo9pikH3QMnVqoqBoIEU8BIHykmGd0Zo3L43FluP3hpRa3zGvs1Utze9sOaaYNQJ/HDd110TKG8yjS529Wzk6Gc2unogY1NcHEHPNIT+jhdlNWa1jZqoUl6BAQShfRCVqQuSGNuvYHZF+7aH+qREprxh8gG5aYFccwFM0viWG+4JVKxINmKO2B73hsw1GmhvuJOy2fS3Q5naEjZkTJayWjau00fHIdim9+uVXW44r+dqP/u55C3EvysSwuZxR2YJmH+tjCWk5M22YKvkSLmYdy8Q6ZOrmY2vLiE/Wg9cIPt38sPXrhO6elA/O3bxrMTVF3ovHJwYivXCOR5DASoFmtJQHm9hLewTlYxKhgqAbDYqyMNOJ71VT23HgoopBkGgeRVj+s901o4if1vhSgXgYFo3Rq8vpbHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39850400004)(136003)(396003)(366004)(376002)(4326008)(316002)(6916009)(66946007)(66556008)(186003)(83380400001)(956004)(8936002)(66476007)(5660300002)(36916002)(38350700002)(38100700002)(2906002)(16526019)(52116002)(26005)(55016002)(558084003)(478600001)(7696005)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHAMfMQhjbHl1fQWb9RNY0lTTH9wxpJIom06LwfWnrAOCzWU4XuPC1gnaXGI?=
 =?us-ascii?Q?1/neEWvwhzVzZqAlsyv4aPrTCLzUHOW/V4kpONF31E4grBpU9ocCFUb5H2Zz?=
 =?us-ascii?Q?aDcE7UZ4uhZVxzP3vTQIcfq0Nn/rhTn7+/VX7ZjhDdV80RPpIIKGG2v3MSVq?=
 =?us-ascii?Q?iRv+jhbgD5Wk2T/x3SFCBXwdQjQnMF+KQE62txbI3ivkKa9T4pfO5d0DH7pU?=
 =?us-ascii?Q?3CBLYs7CUsq0RP1JkCcQHf0TQjuC/z9LQxdGhFESbNBja3tIhdZVcU2uuKaR?=
 =?us-ascii?Q?jLul42ovaNeXpdyn0fdxy+W7uxzWejMizGJpaTEfPNVhu46itiuAbC8XOqAF?=
 =?us-ascii?Q?LZIFuz8HatbNvrbjn/v0WZ+TlMO0FLTNKxCtrA8L0hNmXAM8odYhYg5fETNp?=
 =?us-ascii?Q?i+CB9Wo4tOAVSPXd2brob3LFfLiNR1ebc2hQILfF5xOZyBBsDb2Gutkp27Nm?=
 =?us-ascii?Q?wQtYUsxnwqRKMkXQ9rRyMayjFF+J0iIHzB4LTDi3CpJ8ghvXZzkBkDP+vMgF?=
 =?us-ascii?Q?ELf/Jq0ccOp2zhFbnmcOIAVE1LihQVzwieGQr+1LTpXxbbL42Zl+nGeTQ4+y?=
 =?us-ascii?Q?UTVXY6naqwa4k38KsXvuftnIgMhFYxy4nRlz4nNCpyWFfh5XV5kJx+qk2nZY?=
 =?us-ascii?Q?efTb31b5zIX5NOos10SJCyTjMlaYfKHPhMGeQZAmSvi4XOb7niJ4HxMwbVoU?=
 =?us-ascii?Q?7bX7KXmGckpsiqv0ufs2oKCG/WyrwjDrqxBCq9ptcW6KWtQHaiMIQaingHRB?=
 =?us-ascii?Q?fEq77R61+i9Ni92FwBiz/alsA8OtNHh41O0YZssavVJKLnwd1u0hsSHQBeDH?=
 =?us-ascii?Q?Vp2PfYNxYVf4kFWnpUDEUxGKGgATwelPdZO7vQYTG2M+ejUynx4u8/DvQbf8?=
 =?us-ascii?Q?jkZ7EBXMbxADHwFqZg4o31rQySjttPj3P8b1h3gtPMQxU43Ik5JQjrWOZ+Zw?=
 =?us-ascii?Q?eWKnqYhYRPR9mFVmvQ6h8rmKkLJwT7piaxQ/VP/91RvQ3YkiK+XuZD6CgKh+?=
 =?us-ascii?Q?PUxfM265um8AXGYJcGeTLNJj35AkVBWIhC0iCO3BSDRG+q6VKoYi0fxGT2ou?=
 =?us-ascii?Q?xPQxP+WqHQsQ+JVJ96eFkjadUtm8YtjnIlrnUiR45YRfY8tmqWD185kTF/BR?=
 =?us-ascii?Q?jLfEVKyb+HH7C09Xb8DfTYzK7GZXXgrRPMmHWSiBFKW7500fvCyqg3L+aP3f?=
 =?us-ascii?Q?dFKpGk1qfmzipebnNUj3ymc+wgccKOtoGZI3lj1Gc9tmEIhStQ+SFipr57Gw?=
 =?us-ascii?Q?nknKtFa8GNgXTMSSc8I06QGo8eeaJpf5JkqxkdV5SZ//9jn0oe9ogwcnv3LB?=
 =?us-ascii?Q?IGhmISFqZlipkse7Hsvpi/WR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db357378-c21b-440e-d967-08d9306df816
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 02:25:12.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnYVYff59/WPSHNPgZj9+lkjVsHIebMjVOdxIq2n/u0xVwlFmSUoY3uZ/n65ZwmaqlwZ96OiKo83THb0CbDp/IXPCDo+otuNlnby6sufzSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4583
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160013
X-Proofpoint-ORIG-GUID: vrWsm3YlJhxLBIyg-HpYjk_ewrjgkGvq
X-Proofpoint-GUID: vrWsm3YlJhxLBIyg-HpYjk_ewrjgkGvq
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Michael,

> As general cleanup and in preparation for subsequent patches:

Applied 1-3 to 5.14/scsi-staging.

Since Hannes' series has deprecated status_byte() and CHECK_CONDITION I
had to tweak that portion. Please verify my conflict resolution.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
