Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245AC7799DB
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 23:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjHKVtI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Aug 2023 17:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjHKVtI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Aug 2023 17:49:08 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6182709;
        Fri, 11 Aug 2023 14:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPT5Jyl1ghVtNN3jCB9i8LTnI/0J+HV3JGJh+AVf4TknOUm60kaGtibK2Y+ikPF6ZHJ7bTgMG0NZzwqQ7b1unlorBAm87zRwIy6rPkTAmAxQVSU36QUZ/gQyDHBOU4rfqhwHLNwjuH7TZ3NA6ChqVkYGnNU8B+J0QsEfG3+7V5kPSDEFYVvfgRO9g6l8K0JWYHg8j9jkjonLsmwyEqUsfLd3st7y4w4Lfd193tywa54lFJfd8ocHWiMQaydYZK1gSRQFupo2XWQcw0txN6kOg1ycwvjB04UkZKy2BkZ7D488HKCOATqGc1jVeGRTMkOr6EoJWVqzwLmhjHR9SRBd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DKaGP1M8VwLQK22iKvNYriddVwJmEUq+Ax/BYuJ9nY=;
 b=TtAao837yGXJISCRovGuQerUHjBp6UfAxwsq/NUzRdrYGW+dyavJjm5gxhvRLbAmkAz5+g/N2DDatdCwyWvlkRl3XHpaWCQ0OBub8uG505G4+VTSuXtQnf6OJNUzKx7vjP1KBDksbbpTd97IaIrdqYdvI+CI3FAwNbp3CnlxYY/cXa9GXWCLfBzs7w2+1+qhhw1ehhhjBtJxCCbjLUVwfpOnkP8s6N94NTJa32YLTi4iFgkIIvqAYp/F6Z6y+D4KhOkeoqRx17AElmyiA6pKYTkvCHbCxM5rFHj5MDonMfLXC9CIEoK9kQ7/8I1MyhLQUyVIkjO6uL0ak0r/lmlg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DKaGP1M8VwLQK22iKvNYriddVwJmEUq+Ax/BYuJ9nY=;
 b=Btq5K0O2GyWDcW4TqKp5UBeOxazp8LZbdwzgrcrE//xrHBA7NLYLO4CTav59FcGQ5rOXW8THt5c8fIsqzxYgTCAHoFtWqHBLAmWgytZ+Nra3ojduuQcO4FbS8PGTDpPsctOu0fHPgMkOVrCNjAEpflbXZCEsoVErO6xHYNhRXak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by CY5PR21MB3445.namprd21.prod.outlook.com (2603:10b6:930:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8; Fri, 11 Aug
 2023 21:49:02 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 21:49:02 +0000
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
Subject: [PATCH v10 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Date:   Fri, 11 Aug 2023 14:48:24 -0700
Message-Id: <20230811214826.9609-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0294.namprd04.prod.outlook.com
 (2603:10b6:303:89::29) To MW2PR2101MB1099.namprd21.prod.outlook.com
 (2603:10b6:302:4::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1099:EE_|CY5PR21MB3445:EE_
X-MS-Office365-Filtering-Correlation-Id: ada71e34-0ff3-42a3-0625-08db9ab4c647
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0cP2K/MVSfAw3q3AVulgWEqAa199T+nKRQN36wLlZSWQc6mEdKfi8ap2eXYR5FCzko1GWe5K8ljVwa5OQp24/FoxKs+7NWp4HrvVpeSwoH1MJ2KtHhscEr12cPmne3zhelJXo+hVp39BO+mSiXxfosSgYAZBE/PeFghF/8ZOg+l2ze6rcKR5ufBWVEOT6yc6aLdmnsFexvhU24PUnpTD/0Qe5+/mTFpTWMI+oMqtfly1InN2/CFlSCyroSUPazTD5gDNvVbMdiBEpkzkAM9H8Mjp/61MKDDw0DEEzsQbRFTCdXNPdftD7UT4ZUfiYSBSEIav3nwJt+Gq9EeTPHsTLXdHvqWhgNmEet58sy5f3s9TGZIoqaoDTCabBJ9fLshB3FHwlYTdbJEJ+FaEiaV9x0CqKwXn0i0Edok8Oa02KBuPOeHQt8lUT3ISSS+sRoABSli8NzVzEXezGsElejI2F19I5BOrPzI6UysdAGSkiK7keDIZKOnH2NTOAyjbARLBEAF9LM+OaJuJEppHrwaN76fSZ6uEAQt9O5rhyzPok9yswibF7NOVdowgHj8vN1SRD9pbU9jvOA+i7vseX0YXRswp0eHn4caLxxZvRh7KUP2tCBMVYxTgN+hSI9vcbDkSUyAb1QfsZkQJk+BNRMr4YmNnH2Nu/HkQYyYTDr4dqRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(1800799006)(186006)(4744005)(12101799016)(2906002)(10290500003)(7416002)(8676002)(8936002)(5660300002)(41300700001)(6636002)(4326008)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(36756003)(107886003)(6512007)(966005)(52116002)(478600001)(6506007)(2616005)(1076003)(83380400001)(82950400001)(82960400001)(38100700002)(921005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Gc+oB5PJBJxp/j2f2BPoK5MZuQlF4+0nrVmPhWLhPcLfIxiyUr1jGzTtD2P?=
 =?us-ascii?Q?cXurr0vB5BspdM5k28Vcrc23GibneBySKFWcpTzjnnuYoSjdiGSVAUmQ0hz7?=
 =?us-ascii?Q?uJYD4VZouFz2nUSGc8sBdAt575Xg9wUxRui/lG+kIVO/xumYGV10rQEZ3NB2?=
 =?us-ascii?Q?U2QBg76JtHxSGg+DO/rMtYCJeQaUwFR/HKUO8lYyVjK/k2gnxFdVx6KIfpFa?=
 =?us-ascii?Q?3k6keVqJ8h/HZj1XUxVGE70EHKIwrvePmq8iGIln/iGdmgIgmVaJpNb/gupt?=
 =?us-ascii?Q?JoJf4oc6LhOnkkemsyODhFmoJOsLhyQ0kqIKqG9CnqQ0Zg2XUCm4TDHvgqbo?=
 =?us-ascii?Q?48awMVUB9IETaLcDhnSygusOAC4jx4S9qj2uYsf2NvictzWIrLwIdTf12e7A?=
 =?us-ascii?Q?fej9tk9MlNIxEnn/b1qvLok6Xijlgq8R4+3pJJ0lNXCE2VA9myuZVpWA5wM2?=
 =?us-ascii?Q?+ByE3vP/3Md1hbNlroVv0o33a9ktJP6hBCTytY0FAShE+E9CplZjV3pWnPpy?=
 =?us-ascii?Q?HJZdyLW6VEHukmGF9ZDf7fkGlnbjqZRlwxwUXQk6434MPl1GR1UnMWZ6lWA4?=
 =?us-ascii?Q?8+tOscnSo7DZExEUIuC39yUF+sEhRZ9iE5lIK19ZvRc72G7LCovl3t80YxRW?=
 =?us-ascii?Q?IVtMrw9j4FQqWs56oJEvYouwounzd7macXVBfGEP0PGmTZTIMAWwf32czQO4?=
 =?us-ascii?Q?AOl728wh0r0b3rax4WSis1WydbdYESAY5kWa+CTR9FasGCzQTJo6Rrg/ByvS?=
 =?us-ascii?Q?EGOru+PtPtnz0QxDBL5TvrDCs+3ShRwUSHFMHhKJca4ebLgCJX3BLa5ILiyX?=
 =?us-ascii?Q?ClCCA1OLSPJuxv+7ypmy2BhOJpSYYPNYzAhvSicZX+qeUQay7wrOooKRZdAt?=
 =?us-ascii?Q?f5Y5h79mpsCiSkLTGMLpvv6ul98rMYbmzCpUP8HpbAmofXqFw+97eQvcQEq3?=
 =?us-ascii?Q?IrIY+406DJBOis5xfws96tzeI7ZKtWkjQgBLKJ5T7DhXMw3NaythkMKzeDJ+?=
 =?us-ascii?Q?XF3w4ytnFiQW2cS8T0HWK+Z+rF3U0q0yVAOfVnw5J7JDvMlTN7hp2qh3VTVP?=
 =?us-ascii?Q?+nV/XsWnbfHc6aMppEVD1UGZhlXCnkrfnnxkboqYjT1smNWloO8cGkuYLV50?=
 =?us-ascii?Q?dJywgBAImC33gaMOBRhW9qcODTckdKrxCAy7YH9wc0Max3C30B3oGGsyDg11?=
 =?us-ascii?Q?DmfkGISXzHyVfNClhynznfj+C7jM5Z2x4cQODZ6XhkDiSSg85aryZ+NqD7D9?=
 =?us-ascii?Q?cHQ+TECVkprva4JKOa6V/ZH6RlzEmC1XR+IVIo7BpzXikWdTqWz4sQr3EPO7?=
 =?us-ascii?Q?+5/T6/Zu9tcpapTVpRMxN5LTkUx3ZoeaKAGkzOzyVWTyY4HwKdgMX1z/6uIn?=
 =?us-ascii?Q?kHfM6bOEGGsKnkh97B5jD7X3oD7nvsVYFYQBnjtbgj/VSIA1jZT8QnEeUNMK?=
 =?us-ascii?Q?ZjdTaAJ5gnewab+JedSqrmABk9HxFA0WsUg4+dDOJ3LMzpG4IqQWn319hCTa?=
 =?us-ascii?Q?ZOhANp4NaqNWpRND3tQTFm3NOAB12ZI3ahnjkoseo/8Y/xnKUeIThn2NTE/C?=
 =?us-ascii?Q?e9G2b3SOxPScz7mtdslOQa1AilgkUPL3/UzvvXJR6hgox6/y4gt3q6AnqERH?=
 =?us-ascii?Q?Z5SC5oSkzDwl5lyGqJJdMQrIeipKvMf5rcCrB2GGcVSY?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada71e34-0ff3-42a3-0625-08db9ab4c647
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:49:01.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rq3J1lK5AojilNAh/N7/q+nNnszI6zJmnxq1iB9ttIVV2aZZfQimnUWT4kwWl0Y08HXLOYjbGugVpH7DLHq07Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The two patches can apply cleanly to today's tip.git's master branch.

Dave kindly re-wrote the changelog for the first patch, and suggested a
better version of the second patch.  See [1].

I integrated Dave's comments into this v10. Dave, thank you!

Please review.

[1] v9: https://lwn.net/ml/linux-kernel/20230811021246.821-1-decui@microsoft.com/

Dexuan Cui (2):
  x86/tdx: Retry partially-completed page conversion hypercalls
  x86/tdx: Support vmalloc() for tdx_enc_status_changed()

 arch/x86/coco/tdx/tdx.c           | 88 ++++++++++++++++++++++++++-----
 arch/x86/include/asm/shared/tdx.h |  2 +
 2 files changed, 78 insertions(+), 12 deletions(-)

-- 
2.25.1

