Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075873AA4ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jun 2021 22:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhFPUJH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Jun 2021 16:09:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62654 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230381AbhFPUJF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Jun 2021 16:09:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GK6WoJ008089;
        Wed, 16 Jun 2021 20:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=5kWWFdipMq660W3AYhvPyNTKSc9D7h2yOz+zyf1ub/U=;
 b=PyGlBtzWJuENf8BP49O891UjZZLgU0tmD42qBa8V+8SGsWiDBLse3qq4K5DfjOH2+ppe
 Oe3SQ+loS8k+9lTjmP78hnkmzDQV1O6MG6jU2i/eeGIWW0K/53M9c8JGJWgoZuLKlD7Z
 lfnBy3aGbiPjU8hM7ZQXEdyxEbCfj5wGSJ+lQhtyxU2Y7NbLU7K31zABAnds3TTTs0P5
 9KIgqxXzn+YOfpqT0Q4pWJf3ZX8YpwRpT0FN7vZcN6BgNzrGszbkQtvzPz1k4zZZR3gE
 2Xafob+r3bOeUJ3EydZZHDlh1+LQxJFs+GMKDBZxgJ/3QDfRX3coaOniOF1ywZi6hhuQ UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 396tr0u39f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 20:06:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GK6rjC186336;
        Wed, 16 Jun 2021 20:06:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3030.oracle.com with ESMTP id 396wap8exc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 20:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcX7gy9qFfaoF9Q/1HIMhxVanYf2XaPXEFdRn8/rki8goGvtvRO0rDLR26UPYVwRsEcjYiTRjPDhYmNRYBts6LlGVLXt1WIKSlNpAAqTMjTx2NCnvXTdZDy9S7noMVEc0X0Z6V87VMabY47M8wb+mn33mwbH1CaFn2FIN9ByIptGYR4n80H5PZNoppzmwdll2vRTqCn4xIw+WGwp1oKDen2Ldynk5ckDAh2gg9cULPIs9IGFjHr+XEp5RsMEpngRknPERbi8Yzys9BjA7o37o1E0EPu9ZD0qiouPbh63OipsMlwiCCN6uxd6ulP6cAykKYOlSJS2eW+JvOs75ZBa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kWWFdipMq660W3AYhvPyNTKSc9D7h2yOz+zyf1ub/U=;
 b=USqcx7/4hJmzgB+4S4gGRbkixc41KsXiYU+5073VpZKtl+sOyAMCVp9XyjbI6eUxVv/pUgY9kH5k3DH5fmr5i7tT9Q1hpGMS6LzRpUTwQcopLZF9g/1zm7zW16Gb+Av5AyTwbnaaifrX/yHfS69l/iBCEZBoUfopj911bXWZGiEkNJjqkkYHJwh9TMOpVDuAB2273qvR1RyMLgzj+ZpDdhKi+MmXqA9sHVtURe5mMZ108OjTWdeBGE55y8R9sLCIbuDPyx/62nF9at2LlmG6/qI5nIRj0+6gFUvNISqY25MNjVBBJrpQcvJaEFwaE0iHim0hyNC7CsUkjU+lPx2M7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kWWFdipMq660W3AYhvPyNTKSc9D7h2yOz+zyf1ub/U=;
 b=sOMf1fp8RQlLvTqzCQg7FaIUdKcqYvujpOrZkgg2PknW2e0H9QUDg7l2unkr0V6kTChWiRx3tHw/np8XiEwQFaVJSG/PfRZ/6DXZHGwclCFBkSdDF8cwgeQus91KUu2nRRG0f9e3UAGEEte0tG1wMy3lKDuwT2W0JTX+WaOL1YQ=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4631.namprd10.prod.outlook.com (2603:10b6:510:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Wed, 16 Jun
 2021 20:06:41 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::4c61:9532:4af0:8796]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::4c61:9532:4af0:8796%7]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 20:06:41 +0000
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        KY Srinivasan <kys@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 1/3] scsi: storvsc: Miscellaneous code cleanups
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lf794m98.fsf@ca-mkp.ca.oracle.com>
References: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
        <yq135ti7em1.fsf@ca-mkp.ca.oracle.com>
        <MWHPR21MB1593ABC5154A199022896D3ED70F9@MWHPR21MB1593.namprd21.prod.outlook.com>
Date:   Wed, 16 Jun 2021 16:06:37 -0400
In-Reply-To: <MWHPR21MB1593ABC5154A199022896D3ED70F9@MWHPR21MB1593.namprd21.prod.outlook.com>
        (Michael Kelley's message of "Wed, 16 Jun 2021 19:54:29 +0000")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: SN4PR0501CA0102.namprd05.prod.outlook.com
 (2603:10b6:803:42::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SN4PR0501CA0102.namprd05.prod.outlook.com (2603:10b6:803:42::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 20:06:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65b2f89d-8335-4681-2c06-08d93102420e
X-MS-TrafficTypeDiagnostic: PH0PR10MB4631:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB46310C79175AB8557298BE228E0F9@PH0PR10MB4631.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ce5PBEuQ7sijcEmHohtldynMTATNT9Kb/yGR0KLOkx7Kue/VV3kfbf0j/+Q4ZeHxSc5PWGRjuV5nlTIx66JcQTKQui7vJBOh8GaW5+hPFsgfHL92OhsPWmb4spaVtUMfvkwqykayu9iK5fWF1LqYbhbXSB4zN/3pTa0HqS0+2R9M1s0h8bFQXNdbwGAqa9b1Ev73lJskeolABalysfUQ3+1QToX+B2VxZCeTiNjLH68tus9W6OrOoyDtHvpqpSK3JqWfvypO4R4GaOuecCzBcPJ6+Rq5nxWVE84QSMFx3c6vdCbnNLAhe766Fx8Zg4a/nlzfWH1GRi3ZqOtes+StYm5tUWnrvhRPLXFWFoimB9vfcRBv2G8bSsvKbWv0ScHKkk8Pk38fRTdyoA6PmZes1X+OO+hVUKhF1mBAnRzp1PFdE2ISCJK7DRRCurNx8vhUIu7as6FnAg4ODXlZTrXuf5n0GN9Xm+TECcBFvperp1XxaZAQCxWe3GzqWq/jT37RcrQFktzXRcnQ7l+LzzzmNteExgE6OKKPLxe714oc2/ifv0mNozKyT9Fbn6NFlEC4Rem/auVdH5cbfqAfcTW0fb4FqhYBcuFGn1zAUExRtiXCTeajj3Vmo/ezARQxWZeta3PHKfxLRiiZ983Ban3ZXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(396003)(39860400002)(316002)(6666004)(55016002)(478600001)(38100700002)(86362001)(83380400001)(4744005)(2906002)(6916009)(8936002)(16526019)(956004)(4326008)(52116002)(5660300002)(38350700002)(26005)(54906003)(186003)(8676002)(66946007)(66476007)(66556008)(36916002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Awa59Qxo9qCEz9mHCVOJneUtblk1Y6cS0UC+KwZImR3ltp65JxXJnrfFE18A?=
 =?us-ascii?Q?eu2L/PDlOd+qjALxTzigkDsEa457sINNANwVPd/JBdEspnC4mCudZ/0viWQL?=
 =?us-ascii?Q?4BRePYCewRlR9XCXQ2zGozlPF+lM67WwZ0/o2fA5xjfJ2xx9dzjthP6I5CYz?=
 =?us-ascii?Q?O0kL/XnXoZBXibRgMH3VSsPSCV88Igz9+RMFJDqfEA9wtiv+0hazNQ65UM9M?=
 =?us-ascii?Q?UGDKcnCUc9rtbvwY6txuOFCWBHb5KNxXoKSWIIzJa3eii3k8ZckuZY4MA3NA?=
 =?us-ascii?Q?OBSJivl05Fsyl+/8SJ6CZ/3AsTkJkAi+Nrx92ygHE+gT1/3KjdQUPbgUh/R1?=
 =?us-ascii?Q?UadHOVmUdQJhP4zpilptmJ6KgjC6J1rRjTS7zXIM8PYNltWurUWXCL/7Bzsx?=
 =?us-ascii?Q?I5W+YqctmJ2WPr503hwHIWdJiryeEPSKEmMrMzxBj6gmE41T6/cTorjmvLAy?=
 =?us-ascii?Q?r+vC3sq+1X4jjEop7ueS1bvppWYrN88KxJlOSKqw/TDVLadqNv3a8OSaWZ7b?=
 =?us-ascii?Q?5j0K9/H9i4mwjlXFDNntcFBoClb+nxNI2LxnyZ4cse89DVUB4DW5QkvPcIlD?=
 =?us-ascii?Q?RWeiBCISTg6adS+Yb6vowGAATTYmrbQhDV/gvMRz2P/VJ/U+j2QDB0VxL3YV?=
 =?us-ascii?Q?Ec1lJO+WNJWfoo4mqcuuWxEvrCLRENwvcjkMBXPRjBOP654gZz1lBV17VsiI?=
 =?us-ascii?Q?01CK7Adukay7yB69WZMe6/D6KUrZvUofPDdn5t1V3w9+l6wtC6kI0mm6MgF7?=
 =?us-ascii?Q?qHc5u2kRTh4kEq/Q1R86OLK0xtXr/tQ0pbieat9AxH4GcY2R8XGwEeh8g0Wq?=
 =?us-ascii?Q?J0KEaukjlhN0uWWusYfWLGye1MPRjsGGJuUVubBZhXQ+48DBPAzVO7+ejl/H?=
 =?us-ascii?Q?s/dGNw/conjV5VgK7meMDtKVfGlwkYn2WPqrMlbHogUcvsxlbs9xDNca1hLH?=
 =?us-ascii?Q?QYA9VMaVDeRpHeJZguul0tcoXOjDdH8mnVEaC6ib3XP8IIFFcL0+A+41XsfS?=
 =?us-ascii?Q?KX29NjRmzvVEMGPvt3+0BAXd73P+gqwmDap/jzeHTsDAZwA/vf5gBjsbrKoQ?=
 =?us-ascii?Q?1Ila7PeOuax3tnZA5Vvv9rsu26AqmnzyP85MiSMTkyregutysw/Gl/515NQR?=
 =?us-ascii?Q?IMu1zgwd3K9bOoindGn9tjzyzxFJZ0/xrZ34k8swGsSA8Z3k14/Z26kcWxJ0?=
 =?us-ascii?Q?y8l6ja3wGF6BboOEllj8aXVrRA7BPWOyb2R94FWbp/mmoaS99ILU04xRnZF/?=
 =?us-ascii?Q?B1scKaoKJn+g/WlpN17mW7/XtfvDDfvurZRpSnQQJAcQEbClav+biNhFrYa1?=
 =?us-ascii?Q?nJeuPMaVFMYVkZMHlsDSTTon?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b2f89d-8335-4681-2c06-08d93102420e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 20:06:41.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Hwo+bPT9BDAl7AqtcexfLTJUxyXH8pWWt0AKmZ9DuiZHkHllgkkdtZq8LDw1lLI5EtYyC1qpIrgNlTfFn6pzXKg64npDzt9vp/+xKdeDCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4631
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160113
X-Proofpoint-GUID: sK-XwE6QP4mM4t4riz53pu_IaCCpn0gt
X-Proofpoint-ORIG-GUID: sK-XwE6QP4mM4t4riz53pu_IaCCpn0gt
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Hello Michael,

> Unfortunately, it's not quite right.  The line of code in question
> needs to be
>
> if ((vstor_packet->vm_srb.scsi_status & 0xFF) == SAM_STAT_CHECK_CONDITION &&

> The status_byte() helper was doing the masking as well as the right
> shift, so the masking will need to be open coded.

CHECK_CONDITION is obsolete so no shifting is required for the SAM
status. And as far as I can tell vm_srb.scsi_status is a u8:

struct vmscsi_request {
        u16 length;
        u8 srb_status;
        u8 scsi_status;
[...]

-- 
Martin K. Petersen	Oracle Linux Engineering
