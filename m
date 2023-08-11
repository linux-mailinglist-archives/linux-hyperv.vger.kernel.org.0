Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDF877853E
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 04:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjHKCNs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Aug 2023 22:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHKCNr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Aug 2023 22:13:47 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E97270C;
        Thu, 10 Aug 2023 19:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pp9ctbR7Y0yyH1MA4ksZJwLRQl6Cfsav/Qin4HeXfjv+afLJ0YqTdRjMoLmvSUL1uHxGNheBgM9hzoEhXMZOXYMT4U+5Xjf5THSqXXFmI44hOkLVDPLUswFqvi2cDkkycJcw2A2qNXDpxQRrZHRr6iPn+eSzOAv+4zMECHlTOuCz3qy5R9skTMisFb8CM9vQ3Y3Qt3XCbqColMfe0zuJH9Cu9bjPxCVZqgPQS2asIqcTsWwBkMLSXOa9/v2SBckw4f3isgygYJHC383gu68LnUB/5O5nWSrh0Bz6MslgE7tENlNS0d+w5xXaDy4IO6LxQ1ggEgbUwc/RX9QeamTVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhjeKf6B+eVUXSAqrjYbG9H8dv4xi3+FYrVNYY2IvRM=;
 b=gGPm//bManI9Ox3+pJ6ZFcFgOc2MHjiuHtv7kie/UfxoRCOvrZZwFYYEKJ5C5G60V58fJ/lNFfN4rrA+0iR9VkOZqWNbRbhjKVCRwi0FeaUYhsDKVC//aS6UlzK1YFSGkTNNpJ1/Hmk3i1o/Lmii8Zn1C5wOg4OB7FJ13E1LgxqJEzxFJ+1CYZJfbEZ1H/BnkdrNmSsBDpXyqSut5j2/MZisLZ+FQVz9E+3cmv+plLoP0qSd9gXv8LbT7rh0AkjHz0aogPmTiGkHmV7bvcJUR3MRkqg86BNNQYhPGZURDCyP6Yff0TIT6KNxCBUR6LkAVJc6D5MTopNP4QtNDplsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhjeKf6B+eVUXSAqrjYbG9H8dv4xi3+FYrVNYY2IvRM=;
 b=Quj6M6YYnSRpJCQbFRJgECAEcYqL7F1V4ZVrxk1K0zTKSjjAPrxCt7Ki0oCFyfvVbWMgQVDRBb7JavryKeA2UTnsC8+jjuG/JEMFxDzThek28PCUUjVKmmUfo3kjSkUQhPHtf+4DBZbqJUdortmls30vlWLKLUHvfDGm9eg+XTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MN0PR21MB3072.namprd21.prod.outlook.com
 (2603:10b6:208:370::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7; Fri, 11 Aug
 2023 02:13:43 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::879:607:79:c14d]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::879:607:79:c14d%4]) with mapi id 15.20.6699.007; Fri, 11 Aug 2023
 02:13:42 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     x86@kernel.org, ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        wei.liu@kernel.org, Jason@zx2c4.com, nik.borisov@suse.com,
        mikelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianyu.Lan@microsoft.com, rick.p.edgecombe@intel.com,
        andavis@redhat.com, mheslin@redhat.com, vkuznets@redhat.com,
        xiaoyao.li@intel.com, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH RESEND v9 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Date:   Thu, 10 Aug 2023 19:12:44 -0700
Message-Id: <20230811021246.821-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:303:8f::6) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MN0PR21MB3072:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e8a33d-2444-4c50-7ab7-08db9a109550
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtECb9g1IYPtsvLRfyCHS9cunYQnjMmlt3uoXkZRre3L3mYFWkqZG4wrK3gZbmP5VZfvUIJOKsxoCFoFUxGqCR9HpA/DfWNAjQwOakcyVX0LxEJF3ei94stPqFPeZ/OvtdNgTpvBt72IhLRSpL/2ynqR+vs9eGiAP+Y8K8XAlaoUkvio1zsMaSM7Kq2iiklmRw7Fm19M1KYR+QxDKjtEM2UyHQNSe8zp8ODEMwrlH7YApIJUM6YUYdwRjelf5Ki0s5uptH+tUXH3kVf8KobeXYCNx6UA8YYIFp5r6KCM1a3pDXy+rhcupvAnBF5T9iNcfhS97y7IvTUQGmm2gcjsbBmQxIk3+ydixm2hNPXlgqrU1Zn1/cnWfsHnZpX3JrleqMCatJcUbJsB47SxIqeaRIWWo02MCeuRCgtVziVzA+bG8bJSmlv3F0aDJeFTJRk4Ozw2/b0JOZSxtKZg90D6KltcsDHWZ6/iIFp0ezqaZITzvb/54ZL8U70oebZPdFhgImJekn1gBynNW4o/aE/bQ/wqZjhComHC7LkbvJPlqfHYiyyleaHl0voVuwy+IYaiiiDaePciyL4vqjRAjmZar/6/wVoLczXUWq+VwRlSjfvsAGJGfgoL1rZRcnX6HzXxrICAVaK63RaiMzQ3uAGYFy8X7QjEis7lQkZkcHfEmkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(186006)(1800799006)(10290500003)(478600001)(36756003)(82960400001)(107886003)(6506007)(966005)(82950400001)(6486002)(38100700002)(86362001)(52116002)(2906002)(6512007)(2616005)(83380400001)(1076003)(921005)(5660300002)(12101799016)(41300700001)(66946007)(6636002)(316002)(4326008)(8936002)(66476007)(66556008)(8676002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xtBzm20XStVXKI4ENPhdWIqQ7YyOEoz1zA5BBDR8ghpNnnUcoKjVjcP4TuOL?=
 =?us-ascii?Q?48lliCEv60SxRGqCxdhZVbmdB1SSAsLkiKwJvxkC8qnMIRSPveZhULYQyycy?=
 =?us-ascii?Q?gTh2gO+F2rhqCymqlvAmnG+g3LmNuxFGECHbz6mo59R+XYMQiCKHx9wtatQZ?=
 =?us-ascii?Q?uuEb0u8tu0aq7XWzC4IlqveLa8mZ7gBoUox6ovKwkjXweRyIF3uAMnfOJLUS?=
 =?us-ascii?Q?WlTHS9wAc3jl/XZMa5aZqK4Cls7e53tTXA05qUNgYoAbcdCe/+4NZ0K7BI5t?=
 =?us-ascii?Q?njrM4qQV5Snz+9HGzsAbqcmetPpzVbm8Ahw8JYSw2E5GoocQFPhLZH200UbI?=
 =?us-ascii?Q?bKi+Cnnu/Vbl0q+4AmNSx3JS4Sefd6N7AOkvzbkINrKKNdmJjQGfhOL7MM/F?=
 =?us-ascii?Q?KdLqjZKui5ePBpeuxwYk/ZGlm5YE3QEwhF8QZ6Fk0wXxAjrFqC9CBQTd822l?=
 =?us-ascii?Q?Vj/ovP9gdUDQY+pUMfgPEDCs23sOmhIvAD4laUDe+OMlq6qmhhTXmb4ZYDH+?=
 =?us-ascii?Q?mnNrGvAkPMQ5bLrEl0si9XSoSUc6y5t5ccOmYjiVvxbqDS+F8vaJkJo1gAPf?=
 =?us-ascii?Q?qau4HtdD+uccHPZGRM2tM40yMjKfRXs4h/cesWD43GsxJSNM5K74z1EO9Ozh?=
 =?us-ascii?Q?FhOZmg2u1q5NMvBZwl3JHM7Bf9qWPRU2DaHS9OX8r+5OoCSx4q7oYAwt1/4W?=
 =?us-ascii?Q?X1AhRFutysSGSyqY+VEDrvmEcYbJTObiFrkbFR8uYQDngNSpc3fUUDnSZicK?=
 =?us-ascii?Q?4ktozRqDE50urwX3gBwaqrepAfKETKhjhPRGw8eGaus5/QeYg0gD69Wv1OAu?=
 =?us-ascii?Q?f5nev1NEdAbyYP6tPDyBeGKcFVljKFU/e1VcyM0xWz9Lezk3iDEam6JMw+af?=
 =?us-ascii?Q?Q8yjrNpLLFXQWVhxrwpPJ3A/RPC1rproWRJYwlbo+TW2nWhj+fcvO0zGyuS2?=
 =?us-ascii?Q?6+yAj0HlVcwrfhIRfLwW0OD8Xaai5hIEtBs6utfwmpFIvbmbGVozvYTlae+X?=
 =?us-ascii?Q?u3cWLD18GM6sPycrHpp696rVXB26yXOddU6gLOgKw9Z1rsmr9yO3vgj5k0Hp?=
 =?us-ascii?Q?11gF3aBQ6DXDPaRfkjjkUF+my3RNaKQfShF8vh10PA76NOcGmxzf3+t3j87i?=
 =?us-ascii?Q?8hMsWok8dwngGu7nOjIex8U3tM/RJAzYZEhXdIQodL9uNPDQRfPZtdAcPbOQ?=
 =?us-ascii?Q?cIpsbCRhJvgrPILItFdU8xlbPx2eGTkoSTrb5A0OD94Fyp+WghSp3x0cxHbh?=
 =?us-ascii?Q?AkXSdlxpFgegUhDw8xcbuA63mmPCydmrU6ZT0Um3VFtouyp+UF62YLF199yA?=
 =?us-ascii?Q?m+4inPbgbb8YU955WnwhCAggbVyVQCtAEUqBBVlFxoUMU3k0VPI5CyXorIp8?=
 =?us-ascii?Q?lWoUGe441xYrTUZz1xZNSSsf2ZFFkoCZPYzCeqT+/QDHZp6WzSeqBboXDHwU?=
 =?us-ascii?Q?UT5PXh07oqTVhyNZeUjeONZnGxZ5o03koLh8uY/Anc1TqPtThTc0eLm3ME1V?=
 =?us-ascii?Q?M0Q87JwUeqKrYGikzVVMC8R4RsXd7EqFTpl0y/gFp8CaGMJq5FbbrEPI7FJx?=
 =?us-ascii?Q?cqTyavy0SbTAMdVoYNuz0L1VTA+5n7sp4aQzA73FKnHTSoc/6KENJn/0xrKS?=
 =?us-ascii?Q?lcznP/rH4vJDUhQxx5FWOe3roaccANOLoj3LfNMxxubE?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e8a33d-2444-4c50-7ab7-08db9a109550
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 02:13:42.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1s83qu4shjseH89OcAHBFwO9T8KIqApX+h0bY1Jwl1Z+mh0ilUdmWlGHO6TXJBBm2wv3PCxfgeD1c0WimeBI+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3072
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

(Resending the pachset as the v9 sent on 6/23/2023 didn't draw much attention)

The two patches are based on today's tip.git's master branch.

Note: the two patches don't apply to the current x86/tdx branch, which
doesn't have commit 75d090fd167a ("x86/tdx: Add unaccepted memory support").

As Dave suggested, I moved some local variables of tdx_map_gpa() to
inside the loop. I added Sathyanarayanan's Reviewed-by.

Please review.

FWIW, the old versons are here:
v9: https://lwn.net/ml/linux-kernel/20230621191317.4129-1-decui@microsoft.com/
v8: https://lwn.net/ml/linux-kernel/20230620154830.25442-1-decui@microsoft.com/
v7: https://lwn.net/ml/linux-kernel/20230616044701.15888-1-decui%40microsoft.com/
v6: https://lwn.net/ml/linux-kernel/20230504225351.10765-1-decui@microsoft.com/

Dexuan Cui (2):
  x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
  x86/tdx: Support vmalloc() for tdx_enc_status_changed()

 arch/x86/coco/tdx/tdx.c           | 87 ++++++++++++++++++++++++++-----
 arch/x86/include/asm/shared/tdx.h |  2 +
 2 files changed, 77 insertions(+), 12 deletions(-)

-- 
2.25.1

