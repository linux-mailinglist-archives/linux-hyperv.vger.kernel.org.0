Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADE6F1497A2
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Jan 2020 20:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAYTzE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 25 Jan 2020 14:55:04 -0500
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:55905
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728449AbgAYTzD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 14:55:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl/OGxn0dh/w/XVwyU8IL+7w9PKHptFg0BUjMuCugyLyLmivD/iuwLL+L1GEUV2vvXajIl7nzv61f2AtnXZJ1eU6/2fSbt2HrejVndDJX1enN8x1HCxVPQ1ywlpClugtn7QVsF4fZvzyZChUO8qEMrtvpY+0pCRGqKWDgo9/maJNGhOavf6YnhNtt4o2ArGgOjPfOAlOT2/WR0bbe1foKhsmOTOq7bDNqukJKlmQH2Xsib3e/0Tm5t3MSXWL2Fe45h1AodSFIPcQooEZiYrgH0ItdEI+6gwhLdxsd+ji0TjydOGZzmKJZAtORY0+OHblvhqn7xJeksCCzVrMbJsvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrOi3SRqybB0V8k6PTvcs1pzMnATNngcaIFsMxnHqxk=;
 b=nXd+fWcErY1nhU+FsH3REsn6oKMfH55j0YOzQVr9HxOz+BFnAJALYl2ad6p0sVw1jtUGmCHA27H/j9G3M9HnG08gkxnYEZK0He+a6tVgUmqJv/vC5Q613fepuuQSpM6CGzD7GxPfZ/IXfBOutIAPcdv9Js0HRN/yygbWgb5dZE7tO3Ll3JZ8/EY9wRLfJtCt4c0SoK3F6zBl5vAQYXXBuHYzrOkgiKljgkDHgPlmgbjz8w0Ce46a2LGmCYVyDSSFNzYby4RDlT9hrRTZEBTF73ajdRpci8q4nP58uXpeikUUiIA1l3tZAyIr1kAT1qA09AQrKnap1dC9xRFUDkhIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrOi3SRqybB0V8k6PTvcs1pzMnATNngcaIFsMxnHqxk=;
 b=AsVLWsOVtUiMIddmPRQxgDySjcH+ZvH80+l1sgnVtHJ9BOvw1gtklRHzcgi/br+7BAEChK3WW0YmpJ0OEFI2JjMjuFVg/2eVRmp8IL/K+v9LONFF9G7/tRbgbiSEjY/fNGLRdoYTTcWPSr09ceSJDYx1o9LXgaDca8jlUsgegrY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (20.179.72.138) by
 BN8PR21MB1202.namprd21.prod.outlook.com (20.179.73.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.7; Sat, 25 Jan 2020 19:55:01 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e%7]) with mapi id 15.20.2686.007; Sat, 25 Jan 2020
 19:55:00 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 0/4] hv_utils: Add the support of hibernation
Date:   Sat, 25 Jan 2020 11:53:52 -0800
Message-Id: <1579982036-121722-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15)
 To BN8PR21MB1139.namprd21.prod.outlook.com (2603:10b6:408:72::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Sat, 25 Jan 2020 19:54:59 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f48e785a-3bdc-48aa-9bf7-08d7a1d07609
X-MS-TrafficTypeDiagnostic: BN8PR21MB1202:|BN8PR21MB1202:|BN8PR21MB1202:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1202EAE6E5080F4FA3654F23BF090@BN8PR21MB1202.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0293D40691
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(81156014)(81166006)(8936002)(478600001)(2906002)(8676002)(86362001)(6486002)(4744005)(186003)(4326008)(26005)(6506007)(36756003)(5660300002)(10290500003)(16526019)(3450700001)(52116002)(66476007)(6512007)(956004)(66946007)(2616005)(316002)(66556008)(107886003)(6666004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1202;H:BN8PR21MB1139.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yt7gqUW7v/lTqjl5EjFCsZs5zmi7cA/qIHfob+5TYxlJKLaGHGfmVgLT0RrHvRt5ZNbSTE3LNbwmDOOJcSx8ZCJR+n3m3f7UP/yV26lMq2ZSeOoZDjrnGZDLZxeG4Agwj+x1demz1OtzPBhV/TuMBIPO70wYqfVvb2WQVE2c858/pkw0yRG6V45e8Rrmhc4lLUL+BDUpsQRuX5LlZUvSpwdWVBwVozjkbdb0neOlPTVXg/TlcfFMwVegjuvFkDoMFJ4VIn7Q8mmQOg2IULAvXijnLJOG5JV/lKwyzuOUqgcMo6bn4lhLSZBEFf6x6biXVwQ67Oh1vu93tkBoAZkn0BCAIRi9HdN3JqdcIvWtLZHkCSTC/TXkUCOYpfwC05ZuNfQumaK0U8BeSsX4EN5NnLlcD2Jk1+9THk4WfSvcUFPxVFSLWVrlhnZxHjG1diCysTwa6krszftuNNMBsLk4on292ylG8JZJNgNar17FYRYBQforykkdyT9vmvpYUFxdWhVc0OEWW1r0AJbcruqSIw==
X-MS-Exchange-AntiSpam-MessageData: q7udi0hIt9YWxh8d7D2svrGjPLXSdQn9EKx9wol7LalUhipsORaczDw/E9IZX5wqNyh6/b+JeCHpQheOyzGpEJD0/Mj0AOo+T6gRqXVwTovCZ8Dz0/LUpeOeJZWuug5rtTYmGC8RNTn5CRsrYEFp6Q==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48e785a-3bdc-48aa-9bf7-08d7a1d07609
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2020 19:55:00.7562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BY/t8eWBfIP9sHVfvovPAwolaRef92PQDMsWYnzjw70CZaIb05c7cqN7qyVR1gj0J+uzy2rqi/CbIn4ErXcr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1202
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,
This is an updated version of the v2 patchset 
(https://lkml.org/lkml/2020/1/13/42).

I addressed all the comments from Michael, and documented the changes
after the "---" line in every patch's changelog.

Please review.

Thanks!

Dexuan Cui (4):
  Tools: hv: Reopen the devices if read() or write() returns errors
  hv_utils: Support host-initiated restart request
  hv_utils: Support host-initiated hibernation request
  hv_utils: Add the support of hibernation

 drivers/hv/hv_fcopy.c      |  54 +++++++++++++-
 drivers/hv/hv_kvp.c        |  43 ++++++++++-
 drivers/hv/hv_snapshot.c   |  55 +++++++++++++-
 drivers/hv/hv_util.c       | 144 ++++++++++++++++++++++++++++++++++++-
 drivers/hv/hyperv_vmbus.h  |   6 ++
 include/linux/hyperv.h     |   2 +
 tools/hv/hv_fcopy_daemon.c |  33 +++++++--
 tools/hv/hv_kvp_daemon.c   |  36 ++++++----
 tools/hv/hv_vss_daemon.c   |  49 ++++++++++---
 9 files changed, 385 insertions(+), 37 deletions(-)

-- 
2.19.1

