Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B82EEC51
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jan 2021 05:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbhAHEQh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jan 2021 23:16:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49528 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbhAHEQg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jan 2021 23:16:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1084A8WQ097419;
        Fri, 8 Jan 2021 04:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ftuaTL/lm+H6JG13d03igNmvEoOC4qgMx0ZANFMmyZ0=;
 b=LsPXYeNOpcKgPo/uOWysUoAc5kx2M6KLf85nFBStDuI3WSxBTTZpdKIW0BAcoCZlsbiw
 Sc6cD4L5zy8OuBJVOSan2h81EgPZnuys0sFNfDBbbPMAfLBWgihUXK6L60LpB473IhM9
 kk8yx0xshZeX5QXJNQVtCMitbjWa2YSWu582xUxRmGLMlPvEYQx5q6KXzBOpMl2wDofD
 Luq9CDU1AA7+/6e3uZsnINFgb4j6a+E7/4ekRF+coIzm+GGluyhou0+lEVH2TeD4B4/Q
 l3YimJ8L+LJVD4ELEsQBJTc9SL7cXC+ECAqrPJsVODKbgEOzaBWlEcApG4asz/CfH4xP MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35wepmfd2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 Jan 2021 04:15:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1084AUJe040474;
        Fri, 8 Jan 2021 04:15:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 35w3quswve-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 04:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fzi/3HYKbW6Isg9sGB7w5qWmYn+9OOozxvo5TH4BNo89pjYEx2oWp5+meguLoJ3aHH7dTlGlcwEa3eFPmPwdBO7OimzwyIr/KAyfP+DwKfNHFB/EgfVGHYkrGBH97KakzPvCMpMRfcnjDKJVUgqtC4nc6CN9Ej+EEVpkhF84OfL3560LPyCFRgaMPrr5U0PD5P7WrMIxkyN6wAIeTLVsby/RxLn/p6dw5rNj6R+rJEg4NG+ZVIHfZ/82o7VWFFQdq8jqRLgo3NcjKoRrgoDhgS0/C2nnED+WEX2XnlwPxWiETjql75mqX2hq2W8eACObBmybcKE/X1BFwqwUc8XcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftuaTL/lm+H6JG13d03igNmvEoOC4qgMx0ZANFMmyZ0=;
 b=O6OJJOWsFmtC07xoeaBQwsiM2tPcbXa35UWUu7JlR07uJmsxLAeS3sveAFWQEiVX4mN3ubRb0z/JoFA4lGA1O4MX3QC8D0o0pO16XJH7LNM5VcE1ZEUNl/4nb8dQ8rbTAm7xCAPt6aAIMlbjwMlGU87sv1S5eilFtfzmOWDHoAYzhdMGCkZ7iz+pBwdFpQrcZU2J5ucvFxxIIqhkzSMEvS4T8xwfV82W5Me/sOfFWzOqK/uoAyB0OZ9Pj3U7USDxNRwYjfQO7GDUGrz3E165dlQApcbqOO2bXCKTu8E5IfRpNlkI9SKgiPfJT0uPRF+AkUP78ok1MVXop1ycU64Gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftuaTL/lm+H6JG13d03igNmvEoOC4qgMx0ZANFMmyZ0=;
 b=qI7J0eU0CBMqSZ4LeWNYYLvPkFNkuOeFna1ZFCKXhRGCy6X3e2Y/syc86h3R3D5cZVITUfReFMPCghRAzeNPDopVWn3jvoh1P4ehecd0iYrD/Jo4bZ5z//RdZz67Lp1YCK1/4vBpHIdN3axTLheHy1uK1Feq2jlgYwCJLbO1leg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4534.namprd10.prod.outlook.com (2603:10b6:510:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 04:15:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::54f3:a8aa:a2cd:a3a4]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::54f3:a8aa:a2cd:a3a4%5]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 04:15:46 +0000
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/3] scsi: storvsc: Validate length of incoming packet
 in storvsc_on_channel_callback() -- Take 2
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h7nsawt5.fsf@ca-mkp.ca.oracle.com>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
Date:   Thu, 07 Jan 2021 23:15:44 -0500
In-Reply-To: <20201217203321.4539-1-parri.andrea@gmail.com> (Andrea Parri's
        message of "Thu, 17 Dec 2020 21:33:18 +0100")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: BYAPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:a03:117::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by BYAPR08CA0048.namprd08.prod.outlook.com (2603:10b6:a03:117::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 04:15:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb2cfc5d-b396-4f66-8ebb-08d8b38c12f7
X-MS-TrafficTypeDiagnostic: PH0PR10MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB45345E875F3D76081A51FEF98EAE0@PH0PR10MB4534.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9NwbSvuXH5WHXSaNuxr3d5B6DfcWWXMWSsq859ESywA/EV0EucfNCJnUvLFP/ZP8Eif00yenUACm94fwTQ8JjqEIo3GaQR5nvwuq1ktXPmJTyxZj55Yj4RptvSfhcYVvVxoqVDD3EEVkWBpUTwqC3We3wC+DytKJNZ27jEpnNpxpTT4JyyOQUopjvT1XDqls8nH2GFrnodhz48Txrr4eRAQbG5DDjEUhQFuSyWlpFqHNaJ94GwIfBQ+YTeqYLLN0oeBVJzrdnOxppiEhGeLOZzY4QIDaMdDctFe9tDjkuWXNaEn2T+4jlqNFut1VwSXmwx8lLl0Jl0PFIFwqYfyCnwa53wXs04sTEjuRApsxQGi6E2JpU9+/Jp/xTr9IBdchs6PJiNloi4Q0IKp9G/3sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39850400004)(186003)(4326008)(54906003)(5660300002)(55016002)(2906002)(956004)(66556008)(478600001)(16526019)(6916009)(86362001)(7416002)(26005)(52116002)(36916002)(7696005)(316002)(8676002)(4744005)(66946007)(83380400001)(8936002)(66476007)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lZr7Eywrx9iaR0WgkHEWr1MeNcu5jqtqWYJecWOB0VjJr4DAg9rWcF+lfGF5?=
 =?us-ascii?Q?cNxJscvVs8FjEHwwUSopdviA76N8ttroeexno1KcmdNXdUaSccG5N9m6WsdR?=
 =?us-ascii?Q?APzKv1bS1iDh/4uj0AfhnrKd0geojEGv7gDCt9jh2D2y3ffrjHVkX+Mu8op4?=
 =?us-ascii?Q?MCtxiW0kO8CaB5rjGgY6DtCjRMwtvyGHLh3y4txDS8+7cngL212+lPm8ASC6?=
 =?us-ascii?Q?2/9KZR8K+ASydPLoJwFkSB0yhhCchCkh7qFAeDudtcd+5/L0kgj5I3uIZgzF?=
 =?us-ascii?Q?PT8AqN2b8UDCR4H9DYRkKL0wW3eg/Bhbf/bB9KAyi4VH8y/jUfK06i8W/zJL?=
 =?us-ascii?Q?xO2nrfOkBYc/DCpEeDuSLgwnFGVzcFZnsjGP6vJTaIqcdzG4JqgK5nCppmtb?=
 =?us-ascii?Q?3IbBf2sWhpARniqHjC83SpbnJ4uiddLB8MjmniiQG7oNKyn/fre2kU0I3Iyl?=
 =?us-ascii?Q?0wTURfl1TLc9fb+6pN77COnldCTHha9GBL2aOsG79vsl4MvGE9x9iJU0oL7O?=
 =?us-ascii?Q?OAq6mw84VasUh6TFYxtJY4ol1SQZ7Dzuz2MwxaQ+rI4yydJ77Z4IW1VvjKIF?=
 =?us-ascii?Q?527YjDKfy8rfJqxvgzn3AcEJiMuqIYan1ga3XIWfqzuuasDl4FNVGTgbAr6Q?=
 =?us-ascii?Q?eAvtUCjNI+azEYxiVUqDLm4SRoXxHEpwYJg8DWCdPwzEHGXekKSEavaAgLBi?=
 =?us-ascii?Q?gNKsdpfs0LU3QzJ0iL/a61Bx16c0DuhPqtndF8YgwUAGEuouxs1H91dokGRD?=
 =?us-ascii?Q?bCAb4RGmfYgIbjtToOZ7V9rhESULqH+wTJz1JZVWFFKXJztWkSeINRN/ATM+?=
 =?us-ascii?Q?eg/wPwbppVImQTM/dVQwXu9HjZPuJqQoW2mdl8x2ZjJuTPB5Mbwx1AtRhUB7?=
 =?us-ascii?Q?54bswaGN5WUweKUBpuRVkzVAKdHK/9eo7u+NfGMPFdljunZm3hLWHB4KwpGA?=
 =?us-ascii?Q?Vv5pYHffCe9AmTK9BAwXXrNl2GdGyADB2YZCmkQDMCo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 04:15:46.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2cfc5d-b396-4f66-8ebb-08d8b38c12f7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4HZf3Ri4/boF8OK0xKfMio7PkJMQ9CEjvLS0Q7vpfVc7+oObFiDhZ/ocJmdj+18oZAnqJYHy7ps9hMACw2pI/sXh5NMhxt7JfZ9yLQO56s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4534
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=913 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080021
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Andrea,

> This series is to address the problems mentioned in:
>
>   4da3a54f5a0258 ("Revert "scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback()"")
>
> (cf., in particular, patch 2/3) and to re-introduce the validation in
> question (patch 3/3); patch 1/3 emerged from internal review of these
> two patches and is a related fix.

Applied to 5.12/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
