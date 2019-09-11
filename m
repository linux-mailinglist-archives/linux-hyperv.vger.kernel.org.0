Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6495BB05F8
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfIKXg7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:36:59 -0400
Received: from mail-eopbgr770137.outbound.protection.outlook.com ([40.107.77.137]:34117
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfIKXg6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJJ67HN1UYk6sZZOGwSQKDYOKRZw8CS6kyMp3UbwocCSnUbz9YS/WpMslgf1UGtSHYTGdCHzunW9wroJAlqajRTalPEfR9Ktnj6c7mgIQoYOkAKUXVVM1HwJgDtEx6DpLyf9YEWU9g7yrWXQ8cmnrjYOhmgUQuxbl7wU89u98+E0XKmJRCeIZWEY7cSOQsqGReycwrjmVoKr7YVYFxxGPoAa//IqeMvQzxcA0ZXjtfIWWXO5EUSgQj9j9bE7u7CqbO7xtHV+INCZuHYNmVujFC6FJJx0RL3a4sLbPXCIBURmWb+GKIRbzh9AUm3A0xlCw8CKuSUy0YPOJ6VAv9MuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2QSmQECEQWYq3pnJ91tlicaMDSPyMC173ct8urxqDc=;
 b=WPqL9a1rRfBd/8KgGIuCK2ibxhjYJKSdlhgzcsBDNu2zWqhPvSMJTa0U2gY+/fBpORf8ys3s7j2EuMbSG66lJCNcgMGs6UwCu48cKxdqR1mVAyf9u+4YYoLV2pWVVrbVOQ+35VTCKGKaR48vdsMzCM9vJdcL8OB+S2HEdupWON99XD3iHtVo0sjQao6ZjIiVXU5CrF3CQrzUJW8F22/cQP5x6/qQ0umFNXHhs0QwcC7vNrHlSINs2dEW8VNZYF58XiQGdNT7bbzgO1YtRm7Vz6DqLm0SwX3HrjQkpZMy/jpEqOzDXMT9Q/dBCG1Xck3tfYE+GEg2gZ02vk1gfO7uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2QSmQECEQWYq3pnJ91tlicaMDSPyMC173ct8urxqDc=;
 b=bapCaf2ond0bzI4GLfB931w4FoC9+QFyMyjS8rTMcFspZz5EuGIDGH1Vtxc5UM5h3WoevUlojMnmrEcxl/msPWVwaEwO0bfyneKE5HH4srEwwmYChSbE61cuIj2WadYTxTXyPnb/nUEoXDAT8YIu8xDLTuJW0KGkzJ0cCIpcOXU=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0909.namprd21.prod.outlook.com (52.132.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Wed, 11 Sep 2019 23:36:56 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:36:56 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] hv_balloon: Add the support of hibernation
Thread-Topic: [PATCH] hv_balloon: Add the support of hibernation
Thread-Index: AQHVaPnMH0q3TAr3fUKxaff9nfFvdQ==
Date:   Wed, 11 Sep 2019 23:36:56 +0000
Message-ID: <1568245010-66879-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:300:c0::14) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 091b4a22-760a-42bd-add6-08d73710eead
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0909;
x-ms-traffictypediagnostic: SN6PR2101MB0909:|SN6PR2101MB0909:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR2101MB090950C62270EEC5E337A570BFB10@SN6PR2101MB0909.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(3450700001)(6512007)(6306002)(486006)(476003)(2616005)(2201001)(14444005)(256004)(6486002)(86362001)(36756003)(5660300002)(186003)(4326008)(102836004)(6436002)(53936002)(25786009)(26005)(107886003)(10290500003)(316002)(478600001)(2501003)(43066004)(52116002)(14454004)(386003)(6506007)(110136005)(66066001)(99286004)(1511001)(22452003)(6636002)(4720700003)(71200400001)(71190400001)(305945005)(66446008)(66946007)(66476007)(66556008)(64756008)(50226002)(966005)(10090500001)(7736002)(2906002)(81156014)(8676002)(8936002)(81166006)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0909;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hG0PVoBhDaHAV+MNIjWYjs4UB9FaI5YXSLu0kRBCy63pdVbPRM6PBVAy1CZESvrlowH9+q934BeyZKMAu07RT7j+fdKDmg0h9Qbf9RylYhvXk/sCNYpNlB8dTXsDhuPQDaRsBvUq/OXTj1pbRtE8ZjASPjBloE9rjOjidaNe/Z5QsVzNkUFZV9dspmZwIetQbaBOh3N/6GM0GiyVjbw3Z7hQdM2F086DtK4BrLp2SsUy1Xmv9QWb1SqyLZaFO/kq9cj2WJit35jErQoPHIQZ6gmLeVQXVZcKtUNM6sHJ91H2VTz30ibqmdUD7CjmgmYYiv3v4zAQvbD7BFAWJhD+grfVhh31RvwjXpHhlOxqjTVFd3Tx8SSwiw1viyfcA/ES+1sQyOUUC3h7FP31/A0kxUbDyhhTv7wQ4tJEvsXCOHU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091b4a22-760a-42bd-add6-08d73710eead
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:36:56.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DC73qoSkKRjf2WDtghE/W7GgJ6wHhe49T//2LVCvzmwmanjsGh5IkwKk8/p0zh6voLvrilzPgqOnecvYCi5Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0909
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When hibernation is enabled, we must ignore the balloon up/down and
hot-add requests from the host, if any.

Fow now, if people want to test hibernation, please blacklist hv_balloon
or do not enable Dynamic Memory and Memory Resizing. See the comment in
balloon_probe() for more info.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This patch is basically a pure Hyper-V specific change and it has a
build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next

I request this patch should go through Sasha's tree rather than the
other tree(s).

 drivers/hv/hv_balloon.c | 101 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 34bd735..7df0f67 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -24,6 +24,8 @@
=20
 #include <linux/hyperv.h>
=20
+#include <asm/mshyperv.h>
+
 #define CREATE_TRACE_POINTS
 #include "hv_trace_balloon.h"
=20
@@ -457,6 +459,7 @@ struct hot_add_wrk {
 	struct work_struct wrk;
 };
=20
+static bool allow_hibernation;
 static bool hot_add =3D true;
 static bool do_hot_add;
 /*
@@ -1053,8 +1056,12 @@ static void hot_add_req(struct work_struct *dummy)
 	else
 		resp.result =3D 0;
=20
-	if (!do_hot_add || (resp.page_count =3D=3D 0))
-		pr_err("Memory hot add failed\n");
+	if (!do_hot_add || resp.page_count =3D=3D 0) {
+		if (!allow_hibernation)
+			pr_err("Memory hot add failed\n");
+		else
+			pr_info("Ignore hot-add request!\n");
+	}
=20
 	dm->state =3D DM_INITIALIZED;
 	resp.hdr.trans_id =3D atomic_inc_return(&trans_id);
@@ -1509,6 +1516,11 @@ static void balloon_onchannelcallback(void *context)
 			break;
=20
 		case DM_BALLOON_REQUEST:
+			if (allow_hibernation) {
+				pr_info("Ignore balloon-up request!\n");
+				break;
+			}
+
 			if (dm->state =3D=3D DM_BALLOON_UP)
 				pr_warn("Currently ballooning\n");
 			bal_msg =3D (struct dm_balloon *)recv_buffer;
@@ -1518,6 +1530,11 @@ static void balloon_onchannelcallback(void *context)
 			break;
=20
 		case DM_UNBALLOON_REQUEST:
+			if (allow_hibernation) {
+				pr_info("Ignore balloon-down request!\n");
+				break;
+			}
+
 			dm->state =3D DM_BALLOON_DOWN;
 			balloon_down(dm,
 				 (struct dm_unballoon_request *)recv_buffer);
@@ -1623,6 +1640,11 @@ static int balloon_connect_vsp(struct hv_device *dev=
)
 	cap_msg.hdr.size =3D sizeof(struct dm_capabilities);
 	cap_msg.hdr.trans_id =3D atomic_inc_return(&trans_id);
=20
+	/*
+	 * When hibernation (i.e. virtual ACPI S4 state) is enabled, the host
+	 * currently still requires the bits to be set, so we have to add code
+	 * to fail the host's hot-add and balloon up/down requests, if any.
+	 */
 	cap_msg.caps.cap_bits.balloon =3D 1;
 	cap_msg.caps.cap_bits.hot_add =3D 1;
=20
@@ -1672,6 +1694,24 @@ static int balloon_probe(struct hv_device *dev,
 {
 	int ret;
=20
+#if 0
+	/*
+	 * The patch to implement hv_is_hibernation_supported() is going
+	 * through the tip tree. For now, let's hardcode allow_hibernation
+	 * to false to keep the current behavior of hv_balloon. If people
+	 * want to test hibernation, please blacklist hv_balloon fow now
+	 * or do not enable Dynamid Memory and Memory Resizing.
+	 *
+	 * We'll remove the conditional compilation as soon as
+	 * hv_is_hibernation_supported() is available in the mainline tree.
+	 */
+	allow_hibernation =3D hv_is_hibernation_supported();
+#else
+	allow_hibernation =3D false;
+#endif
+	if (allow_hibernation)
+		hot_add =3D false;
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 	do_hot_add =3D hot_add;
 #else
@@ -1711,6 +1751,8 @@ static int balloon_probe(struct hv_device *dev,
 	return 0;
=20
 probe_error:
+	dm_device.state =3D DM_INIT_ERROR;
+	dm_device.thread  =3D NULL;
 	vmbus_close(dev->channel);
 #ifdef CONFIG_MEMORY_HOTPLUG
 	unregister_memory_notifier(&hv_memory_nb);
@@ -1752,6 +1794,59 @@ static int balloon_remove(struct hv_device *dev)
 	return 0;
 }
=20
+static int balloon_suspend(struct hv_device *hv_dev)
+{
+	struct hv_dynmem_device *dm =3D hv_get_drvdata(hv_dev);
+
+	tasklet_disable(&hv_dev->channel->callback_event);
+
+	cancel_work_sync(&dm->balloon_wrk.wrk);
+	cancel_work_sync(&dm->ha_wrk.wrk);
+
+	if (dm->thread) {
+		kthread_stop(dm->thread);
+		dm->thread =3D NULL;
+		vmbus_close(hv_dev->channel);
+	}
+
+	tasklet_enable(&hv_dev->channel->callback_event);
+
+	return 0;
+
+}
+
+static int balloon_resume(struct hv_device *dev)
+{
+	int ret;
+
+	dm_device.state =3D DM_INITIALIZING;
+
+	ret =3D balloon_connect_vsp(dev);
+
+	if (ret !=3D 0)
+		goto out;
+
+	dm_device.thread =3D
+		 kthread_run(dm_thread_func, &dm_device, "hv_balloon");
+	if (IS_ERR(dm_device.thread)) {
+		ret =3D PTR_ERR(dm_device.thread);
+		dm_device.thread =3D NULL;
+		goto close_channel;
+	}
+
+	dm_device.state =3D DM_INITIALIZED;
+	return 0;
+close_channel:
+	vmbus_close(dev->channel);
+out:
+	dm_device.state =3D DM_INIT_ERROR;
+#ifdef CONFIG_MEMORY_HOTPLUG
+	unregister_memory_notifier(&hv_memory_nb);
+	restore_online_page_callback(&hv_online_page);
+#endif
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] =3D {
 	/* Dynamic Memory Class ID */
 	/* 525074DC-8985-46e2-8057-A307DC18A502 */
@@ -1766,6 +1861,8 @@ static int balloon_remove(struct hv_device *dev)
 	.id_table =3D id_table,
 	.probe =3D  balloon_probe,
 	.remove =3D  balloon_remove,
+	.suspend =3D balloon_suspend,
+	.resume =3D balloon_resume,
 	.driver =3D {
 		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
--=20
1.8.3.1

