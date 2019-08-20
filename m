Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC68C954CE
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 05:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfHTDGo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 23:06:44 -0400
Received: from mail-eopbgr810128.outbound.protection.outlook.com ([40.107.81.128]:6895
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728903AbfHTDGn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 23:06:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzR8VN/shf0JESnJj+BmmkIvy6g8YDzCtmHOh3OisIpZ4BvTouTARmEFBpb6YB+bamHyJh3h8ZcEPU1P03VodhVZjdK7mRcZbyC5LWJo/H6eK1sMpR/1TK0V1+rE7mAS5Hhveng+fEhqdbM18IWg0bREXInhybbP5uH6kZIVkkfqxZfkR/aCQ9y3bbOEPEygOZvPI8LfxDrJvQ/OQQ9y7G9g9fF/AhTyx7eli+y+vPAaXHfYPapzbH3yx3yp8g/aDHSlc0V6GdFQJrhRuwOsfAYdUjkUiX6WBnd5QI2YOzCrDGHKa/5eLBPGo3UcCkklkeioS2mgE6OZdRJr5vuriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=engXC0JQvMC5oa+0ngTkgZObGs64ENMZTkTbDuHZTBM=;
 b=M4i1p8KE9RDroWA69/8LY6MQVJuVsdzNW2mHGiMRrsvLBZjrXBuuU+G0O2KHPkbzYQsjMa+hjXk6ZOTT+kWJ/jZWnQiXJ5N0e9bSvVlFiEI5hITE8cBF+YBAtEnuRrJDn1ikvda9n5dzd7GPKEROgvNvDEYqKWIslhDOeIKSnqR66GYWUa2GD8x8BxgWoNmkeg3k1badDMQm+/TJH26BkXqf00RD516xNC065wiGm+TpuWA3iTRwMfpQVPMdbPY7vPTbB+lWl/7Cpd/loYIOGX7Li73L4Fzj1qdDpQUp2XYRDygxRbqBtG7aLPqThHOBGUttBHTUj9WoPtnXr7oA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=engXC0JQvMC5oa+0ngTkgZObGs64ENMZTkTbDuHZTBM=;
 b=dg68rP52Gh6C36c3GSD1GUzlI5yNq3Gg9UlPmy9K/ulZJo1V81ij+dzwR0cBwhyna7NdG8oOuQpiobvhuHmZk31HF92z6mtABrG9QjVgFHf3iuM8JRHShttOc7VRE+DMZ12Yah4inF9b/V2zhk7iVGiPTbktS+TntDnftwlALZQ=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1055.namprd21.prod.outlook.com (52.132.115.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.5; Tue, 20 Aug 2019 03:06:40 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 03:06:40 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: Remove the unused "tsc_page" from struct
 hv_context
Thread-Topic: [PATCH] Drivers: hv: vmbus: Remove the unused "tsc_page" from
 struct hv_context
Thread-Index: AQHVVwRJCJjvEb6GrU2dZRHI8UO6LQ==
Date:   Tue, 20 Aug 2019 03:06:40 +0000
Message-ID: <1566270393-28009-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0054.namprd12.prod.outlook.com
 (2603:10b6:300:103::16) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95fc453e-9a0a-4bc5-0f40-08d7251b6c1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB1055;
x-ms-traffictypediagnostic: SN6PR2101MB1055:|SN6PR2101MB1055:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB105594894D1DFD67F56B39D7BFAB0@SN6PR2101MB1055.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:268;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(50226002)(1511001)(7736002)(66066001)(52116002)(316002)(10290500003)(10090500001)(53936002)(8676002)(486006)(4720700003)(6486002)(102836004)(2906002)(8936002)(4744005)(5660300002)(6506007)(2501003)(71190400001)(256004)(71200400001)(386003)(99286004)(36756003)(86362001)(66946007)(26005)(43066004)(81156014)(2616005)(81166006)(66556008)(66446008)(14454004)(6436002)(66476007)(64756008)(6636002)(110136005)(54906003)(478600001)(305945005)(4326008)(22452003)(3846002)(6116002)(186003)(3450700001)(476003)(6512007)(107886003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1055;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r/ZeNxCJNnaf5DcVsiF3DkyO7QCxh37B362lntbzFMrNkbvUF9eO/ncMdvUn5ra5iZ6fvsjw4aPqhfQGqerg2ZUEMcIVJDw/zDyQRGq5UmZpxghZ5yz8WHkrik8DLX7mQV5CLkm/cXxNzhiX02QbM3Np/s4o3+ga+k/OBRcPPWaahosgeYEEZqK+vIfZXgZREXChvWhLaLWfO2Uj1uMzKuKTKpPEixPuMzC33IIYqbTTp0PHDMZnsb0KKzmqyR6ZNHYcW3VTJBLjMlYwyazxrRXKBBH+FUeAdU7ZNbpz0QSAyRV1zBUMHTwWqey1xxAvOWcYfuKjxoxXw6iPeJA0Y4z0TfYI5JIbzmvk1p43uIMSuem1FT7pYA2s/rBY9IOA8VFCI/Q2aiuXLvTLQbbE3UZIYoDGy5N5Iam9Vo/o/vI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fc453e-9a0a-4bc5-0f40-08d7251b6c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 03:06:40.6630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d40boNR61YdJgnhNW/i08D7xTKWiuOgCFpZxfeG7kmKjPp1v9pDx13x362ntmEGx5eXF0mgUbWwQG+1omMJ9zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1055
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This field is no longer used after the commit
63ed4e0c67df ("Drivers: hv: vmbus: Consolidate all Hyper-V specific clockso=
urce code")
, because it's replaced by the global variable
"struct ms_hyperv_tsc_page *tsc_pg;" (now, the variable is in
drivers/clocksource/hyperv_timer.c).

Fixes: 63ed4e0c67df ("Drivers: hv: vmbus: Consolidate all Hyper-V specific =
clocksource code")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/hyperv_vmbus.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 362e70e..fb16a62 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -146,8 +146,6 @@ struct hv_context {
 	 */
 	u64 guestid;
=20
-	void *tsc_page;
-
 	struct hv_per_cpu_context __percpu *cpu_context;
=20
 	/*
--=20
1.8.3.1

