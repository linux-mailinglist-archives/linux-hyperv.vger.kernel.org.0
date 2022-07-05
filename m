Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB95672F3
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jul 2022 17:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiGEPpB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jul 2022 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiGEPo7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jul 2022 11:44:59 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FAD15FF6;
        Tue,  5 Jul 2022 08:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQ3IdZ9p7q5gDWLLxx0GKlM3h0uziltXE1hggWwmpS5mD6OH6Djk9nIrPdk1mKvJ7TLjgm+JlWjSb3V0/lS6Wck6Im/jeOCMGj6auvDECgXVcN/C3AaXirLzUvmBnm7OMJYsMndOGMvmXFKY3xZuy3aTGC5eAN9Lkua2fNWbQ5m1xQrKaEJdAj4NrhPT/YLQ17TgZXNxYt0pvmbAre98Go03q4vQw8zgAFGLgLCGdvNmb4j9a6jEYylUwJ/dv6xqt0Of5lvbWspbeJbFsZLkcCEpNG/mkR+TQajEd5JvXJrorG2AyrJpjfz1SJYzwzErxqTbdL+7vQKjepkpZlG0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNcllGzmWWIudTIpKdRwJSsDHDemRdnOdiTEd0ddrWs=;
 b=MpzBiBxl9bj1dP2l/tqPBKn8KI64vAG0caAphe7JBE3ctmpi7o5KOeFvn9DwMXwB2PFFHUloLlJ89ylPxjGoByjjsMMGXkGgvDB0ttO3gz0CCAD1rCb9sofWl9WHRcCb3bvIjU0gFx6l2PBP+AtUnVsmz2r4Qn8znuOCcSHsOLC2RJd2zWi+dgSMWmtakBzm64A5rMb0f+BUKMZrC/bc+OW3u1L+Y0msrDLRu1kz/gUJw1+jJj0WcfyJPmoz6n7Ep5Ua3gauiKirIW976Nubob7Ifm3Y/faVspreSSNQPgUVzJcxt6mF+hwvUZr0NuubTw0ecPkoTDlltHkgfRtkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNcllGzmWWIudTIpKdRwJSsDHDemRdnOdiTEd0ddrWs=;
 b=g+Z8J9PhwDjMjlBkbIYfN+LheSUR97ozwVOvOSPtrMoyCX4Jw0EtmGYj+xu4+WBhtAIAgb0IyG4rfmb44SY2kVvG50ZSiiPHaQLCge+3CFJHh/qg1z/Y8Yr1kwEvhxS8wjUgk+mjdoI/Cw1Yuf4G/eVS94KLhDtgVndj1bTpYRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM6PR21MB1322.namprd21.prod.outlook.com (2603:10b6:5:175::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.3; Tue, 5 Jul
 2022 15:44:55 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6%4]) with mapi id 15.20.5417.010; Tue, 5 Jul 2022
 15:44:55 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 0/3] Documentation: hyperv: Add basic info on Hyper-V enlightenments
Date:   Tue,  5 Jul 2022 08:43:39 -0700
Message-Id: <1657035822-47950-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:300:ae::24) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31bb6b49-1417-4159-9d18-08da5e9d4ee8
X-MS-TrafficTypeDiagnostic: DM6PR21MB1322:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNn9qYbCI1Mg5ZzPdtCRmbg9CHZNMZx0ktF4UhOAJpHzmeGVxaKkVAqLnll0z2leiftuKqVezp2mrb0/2P7xbNSG+UKKpSdIl4PlkC/z/77v924/LavZ2WTjDaMYfRtY7l4NAfmuSn1wUiP15sZg7gkOnqVbsDA13x1yvPs87k+HZXY0TZiokCOgzlY23W6tt9hef+kS3Psbgr8Qch8stA6GGkfIokhknBEOW6tjZ80KyXtSQdfLed419jVOzQyBX9ZzfyUeP3c4ClUlkkw+T9XMO5CmthmqInZnR/dfyn2QBvSWSX5uLGzTq7yVuBVycNuCgwFhtLwLpaLbMh46cIURbjyH//Jk/fpHuTUHmhRzpNiZG/cvSB0Eo8Y3PzwoSLPd47Gh5SGUmZyM9XO1Iu3JHzkbT1gXbrIZj3AJ3zmljtwdmcTvrtBGfSuiv+uN5En4DgvBduhjHF/ri5+rOssvXVpplNkE/g11iSEKspmr9/utkCISfFa8O0I7pJ1nYmxJ+MYT1B6lHK5nXuwE5Y8Fi4mTbYPExB2MMnkM9cJUYDZU5/Y3NsHZMo8F/FLGaBvb4EEJYCU/t3NBdjlePYVytW4NVQVmqdNzf9tJw0GHmSBu3N+nxGg553e776JZQy5vJzgZpb9BvHxhFN1SUJZiOBe+cp+v0hCpWt6Rji22ky86fVE5rbdvuDSL8kOPwOMgu1j/BJQHK7OjQixaqyTny5fsJhEZTEXC8Ad1XoZfiYex+bQIteBOn1SW9bcD6oW6ts7q/jFJbcKHCFriQpll3hQQGgfQZbA3WBjeEtmDQBbrR+wZS4N+grGqOcDM++S31Ai8xUWJk57iuVaj4k6Ag1nGHy2UFMpopZm8dcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199009)(26005)(41300700001)(6506007)(2616005)(2906002)(6666004)(107886003)(66476007)(186003)(52116002)(83380400001)(6512007)(478600001)(6486002)(86362001)(5660300002)(8936002)(4326008)(36756003)(38100700002)(38350700002)(82960400001)(66556008)(316002)(82950400001)(10290500003)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5prJv/XIuTuhozIT72rFFyx3dJTZFNvYzw4y9qXoL9/mPLYfP01B99Two9ii?=
 =?us-ascii?Q?0zDwGxm4OMcn0V9gq1+A1lpDHjosmz16/ChW01two16/DVwuVKVIXDv0MEBd?=
 =?us-ascii?Q?o+fYCZCOM2SM+1KVwzGiO1jq5rEA1CmsN6dtDV0oVXcMjJASbudAG5ZpwL5R?=
 =?us-ascii?Q?AzIJ7tyOdPjkLwt9ua0QjN8wlFrpXiQ0CxKRw1cF09k+xDxgOKDTJdkk/Gt/?=
 =?us-ascii?Q?BewIxsMqYl2EQVeLKgfEkGHhiODx6Yr2r2fU0LcGr6vRcdxEWclc08lVOBuP?=
 =?us-ascii?Q?uJIBvEFSJOTDJ3azf3N2FUduHLSWOLa+1oLK9BjLI3HOrnPzoCqMAol5yWwJ?=
 =?us-ascii?Q?PMpd8XBQ7hqpJJ/oJGJ/gJ6q8sTMS4aB+O5osMJhGxz1hd44lQY/M8I7ufKO?=
 =?us-ascii?Q?oeS3Z2nVxOhD6RhhYJEi1gvG+9Ng9THBiMcNX6YS9iRVlhAU7f1v8AkF26LN?=
 =?us-ascii?Q?2JPqJZqQQYU20oTlIEH4tRUtCpeUvyYToE/bMepe1zhtOvTHhhlz5PlxHW+k?=
 =?us-ascii?Q?AevpI16iJcPkD6joDtxorg+MlTztWdWO4KVFGzavgkdV9b4KlNp+DiVtAO5d?=
 =?us-ascii?Q?zcvPzQirEb2NpOaJCvPOOsWHY/et5ATFEAK5+UrQ1oKeG+o0pBM0GHFewB3a?=
 =?us-ascii?Q?pqRL9rSYjBZfslyetOJ/cUSbNfOtJ1+Rd/TiUStThWKtNkXf7wMXqSUJvaxH?=
 =?us-ascii?Q?4VMBXNzFqWLpY2ngv2ysacsE5Af74pwBU6Ii0+DkzQf2lz7Zkgn9YAfnf22Q?=
 =?us-ascii?Q?Q64byzJqXvth0uZiwibSwy4nBDfS1zhgNSbOzSNYvK8zKNTcUdQxiitj958D?=
 =?us-ascii?Q?OSb6nGF5qbQZVhXRMHhriByC1ziZ84EdYobFE4oci6MvPcX477SOrrJm3OAO?=
 =?us-ascii?Q?mrQfeBpczhoKaT03vTHTWD+JrQbeKvzeOa1BMCwYZC5Y/5xawY+3Kfh2dqlr?=
 =?us-ascii?Q?+UXNBEUWYlfLx93Mk2pFdYGvT99qPLjkrOzp3gl234lfbY5vaznNYYpqUgxi?=
 =?us-ascii?Q?tsLha45+6Ac50Jgh+H1Y6+TVZB3H8K/D8pTan/s/0vDMqnpqD+7Rj9VQ7rW8?=
 =?us-ascii?Q?X4D8ZaucwSwftMAzTnlppkD8vN2Mhzz8tt8JWl8jX5/uZShce7XjqqJ0B9Q8?=
 =?us-ascii?Q?WtKYvrSCLr4m+DAl8ea2AN/M8AyKOgtL4Y43ROvZ17nghoxXgEmTEnHVs+QI?=
 =?us-ascii?Q?gIQp4zfHi+2D7+QRA7JtrOGdSa1KvzVNl2iRmkpVP/gbG7VtYkxHNnY7JM+P?=
 =?us-ascii?Q?ZjKnrVQY4lF7Q+WTPI5a5lbbrzCcYEJeyaCXbe+m8t/tQzaF2biW/+gZ8x6Z?=
 =?us-ascii?Q?z0QI5NJ4rhzPo8hLLhdssr8KwLB/ePDMXtX+dg5+5oJUnfrzq1rusWYraPNE?=
 =?us-ascii?Q?x4Xvd8Kr7im/Gh+eR9Xi/yhraeySe0OH9Pg6YbIryvyd2mdAl1d07+UWZRJN?=
 =?us-ascii?Q?fssknuppe1RbPrH00SnogajOiqX8cBh7z0XgLCDD4ItoEKtEkn9qIYCjrlpT?=
 =?us-ascii?Q?3556nEtfh7/uPLvyNUhaUqHIpwwxxkk5CrCY+8nOIZEb2YBTyxud3qMX8L2o?=
 =?us-ascii?Q?qFo/by8DCNCvV0WbcGoGpEErNbocxkhMjK/Y4MHoGHHGlzUfoG9vErWROHfU?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bb6b49-1417-4159-9d18-08da5e9d4ee8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 15:44:55.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zfbh/dliHJd4lxPEI96qm5qTTdZtI0PDM+dsIQuzMiNF3WWxWVLIefwN5fohQDguzO4Fw4ZXSzqFmXVCey697g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1322
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This documentation is a high level overview to explain the basics
of Linux running as a guest on Hyper-V. The intent is to document
the forest, not the trees. The Hyper-V Top Level Functional Spec
provides conceptual material and API details for the core Hyper-V
hypervisor, and this documentation provides additional info on
how that functionality is applied to Linux. Also, there's no
public documentation on VMbus or the VMbus synthetic devices, so
this documentation helps fill that gap at a conceptual level. This
documentation is not API-level documentation, which can be seen
in the code and associated comments.

More topics will be added in future patches, including:

* Miscellaneous synthetic devices like KVP, timesync, VSS, etc.
* Virtual PCI support
* Isolated/Confidential VMs

If you think I'm missing a topic that fits into the overall
approach as described, feel free to suggest text, or let me
know and I can add it to my list.

Michael Kelley (3):
  Documentation: hyperv: Add overview of Hyper-V enlightenments
  Documentation: hyperv: Add overview of VMbus
  Documentation: hyperv: Add overview of clocks and timers

 Documentation/virt/hyperv/clocks.rst   |  73 ++++++++
 Documentation/virt/hyperv/index.rst    |  12 ++
 Documentation/virt/hyperv/overview.rst | 207 ++++++++++++++++++++++
 Documentation/virt/hyperv/vmbus.rst    | 303 +++++++++++++++++++++++++++++++++
 Documentation/virt/index.rst           |   1 +
 MAINTAINERS                            |   1 +
 6 files changed, 597 insertions(+)
 create mode 100644 Documentation/virt/hyperv/clocks.rst
 create mode 100644 Documentation/virt/hyperv/index.rst
 create mode 100644 Documentation/virt/hyperv/overview.rst
 create mode 100644 Documentation/virt/hyperv/vmbus.rst

-- 
1.8.3.1

