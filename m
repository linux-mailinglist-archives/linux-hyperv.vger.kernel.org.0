Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5305BA5E86
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfICAXh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:37 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728120AbfICAXf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaRj82GvFabTjWFFk9Zg4sQOpMFEOL0b+pi6qIdNITwi9eVLlgxG0Xd2yzOAXpFLFGg2EJ4mhCxxATMaQqCcrkFawY4c/qcNJVYgclqy3BNYqIOazbk6lY455OR4hmZz/h+hJGnB+yDE9xDrti0+EsAQ+J2F0hIqTOhOB/zJAt+vWFPjhghaMcA1U0T+aQUJhfZF7vDDVkuAC89lhPFRAaYKN6ToYsRyXC9wiiETzCzasdQORu5xamPWhmsZRe4sJRZWamvQ939h7HzhTHIZCII4MVBoZnJYzPOMEXfY1cqnPXKELHb4dtLCJIN7kB4gmrx/C80VUCnP6ebUIwM/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yB6X7+2VJkyBW6oNR/EbjwmQgg90DjczJQ+/bX2nGI=;
 b=X4gJwL+lwLupvBMaWGhWVjJMJ6tzhX8+o0tnMxIfa/jsyoQJzlKCORZtPwT7HnwjDrpvSxke4EmzXPPMF3hTIg17QDnSTz9YlMGFYK2xcj6VL8FEGN7qstO14HTWFiUvKvL7LQompgRVZFXxq4rpAh41EQGZfYunH6/MR6NcYcSgASTRKnpN3K2aWM2Kf1MTP71suJ+9nMk48OTmXFZjMeU5c2JV+xUiZcVTCPKRkjHKrJsgQ8VOdD/xzd106LE1BxzgK6zQCFgOymxibb8k+Dn9VcT+BZXMWBtz2NpgGmJnOeOm+2qNHvENAy1nbn37rat4PUbPY4Dp+EBpUE+ibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yB6X7+2VJkyBW6oNR/EbjwmQgg90DjczJQ+/bX2nGI=;
 b=AmfaEP/jANpCJoC2siOm0EkvNqEpMRW4DAKEYqpz+vaSYEi75Klpmsw6h0TVmDqMeT+Ar3hKjIQ5yBWVDKK5itrQRmXSWPuYK2EnC/YnWWo7O9meVLr4OfNFHNlQFKplzdatZ3kklZnHKntMX9D/qU0yms24Jofy223/En/0Qzk=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:24 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v4 10/12] Drivers: hv: vmbus: Clean up hv_sock channels by
 force upon suspend
Thread-Topic: [PATCH v4 10/12] Drivers: hv: vmbus: Clean up hv_sock channels
 by force upon suspend
Thread-Index: AQHVYe3M11QygrJEL0K8AAqTpa/5Qg==
Date:   Tue, 3 Sep 2019 00:23:24 +0000
Message-ID: <1567470139-119355-11-git-send-email-decui@microsoft.com>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567470139-119355-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:301:1::15) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0e9105a-1ed0-4432-4cf2-08d73004ef18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1054D47DC59B0077405417F0BFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(15650500001)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K8IFj90M8TJp02aYR4KXdJEMUvUE21sDTVXnP4FDQcFPsCiGBnKrS4ckN59nK2RQNI6B22YGP7NDij/MMXZf4INtCNPLyrFScBu2YlZbMGnLe5VutwzZgnw9bALyPzNAk+sdW91IAA8alt5soMpsA71w+njUkqHsOxkh7fpQwZedQQd6+xGF2nMuq8trMJF1MExGEbsgz3t2NfCqjy/qDuXl67No889TFP6E33qD//kGsHyTS6CWHzhxvDv1JYL/bxHW6DhvoWSCWm7LzICLmAIDeRpONcounRXP6MFBcWnMNEVKMBTxbS1o6LFVSeTeMFHXPRsUrFvUXF3IxyznpaUj3jBgQ+GgoQ5UVeiaRUJXeaek2aq7Y+CJoCxn/SXWvMNCbD8OvZAlTRXoqkyGpeKoq0ZIOLvklrn4AvhGrEw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e9105a-1ed0-4432-4cf2-08d73004ef18
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:24.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBy3scg2cwYf6IOyg27MoxBEcHNQse+PiDI3OEZy6hiLBOk35zXgcHGQwT51HXhQ9a+MojxSyn1lVwl9Qjq/0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fake RESCIND_CHANNEL messages to clean up hv_sock channels by force for
hibernation. There is no better method to clean up the channels since
some of the channels may still be referenced by the userspace apps when
hibernation is triggered: in this case, with this patch, the "rescind"
fields of the channels are set, and the apps will thoroughly destroy
the channels after hibernation.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index ce9974b..45b976e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -24,6 +24,7 @@
 #include <linux/sched/task_stack.h>
=20
 #include <asm/mshyperv.h>
+#include <linux/delay.h>
 #include <linux/notifier.h>
 #include <linux/ptrace.h>
 #include <linux/screen_info.h>
@@ -1069,6 +1070,41 @@ void vmbus_on_msg_dpc(unsigned long data)
 	vmbus_signal_eom(msg, message_type);
 }
=20
+/*
+ * Fake RESCIND_CHANNEL messages to clean up hv_sock channels by force for
+ * hibernation, because hv_sock connections can not persist across hiberna=
tion.
+ */
+static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
+{
+	struct onmessage_work_context *ctx;
+	struct vmbus_channel_rescind_offer *rescind;
+
+	WARN_ON(!is_hvsock_channel(channel));
+
+	/*
+	 * sizeof(*ctx) is small and the allocation should really not fail,
+	 * otherwise the state of the hv_sock connections ends up in limbo.
+	 */
+	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL | __GFP_NOFAIL);
+
+	/*
+	 * So far, these are not really used by Linux. Just set them to the
+	 * reasonable values conforming to the definitions of the fields.
+	 */
+	ctx->msg.header.message_type =3D 1;
+	ctx->msg.header.payload_size =3D sizeof(*rescind);
+
+	/* These values are actually used by Linux. */
+	rescind =3D (struct vmbus_channel_rescind_offer *)ctx->msg.u.payload;
+	rescind->header.msgtype =3D CHANNELMSG_RESCIND_CHANNELOFFER;
+	rescind->child_relid =3D channel->offermsg.child_relid;
+
+	INIT_WORK(&ctx->work, vmbus_onmessage_work);
+
+	queue_work_on(vmbus_connection.connect_cpu,
+		      vmbus_connection.work_queue,
+		      &ctx->work);
+}
=20
 /*
  * Direct callback for channels using other deferred processing
@@ -2091,6 +2127,25 @@ static int vmbus_acpi_add(struct acpi_device *device=
)
=20
 static int vmbus_bus_suspend(struct device *dev)
 {
+	struct vmbus_channel *channel;
+
+	while (atomic_read(&vmbus_connection.offer_in_progress) !=3D 0) {
+		/*
+		 * We wait here until the completion of any channel
+		 * offers that are currently in progress.
+		 */
+		msleep(1);
+	}
+
+	mutex_lock(&vmbus_connection.channel_mutex);
+	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
+		if (!is_hvsock_channel(channel))
+			continue;
+
+		vmbus_force_channel_rescinded(channel);
+	}
+	mutex_unlock(&vmbus_connection.channel_mutex);
+
 	vmbus_initiate_unload(false);
=20
 	vmbus_connection.conn_state =3D DISCONNECTED;
--=20
1.8.3.1

