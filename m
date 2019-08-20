Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8477A953D4
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfHTBw2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:28 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:42832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729047AbfHTBwM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJs/36GrA5aiSiPPKWp5WAra60kJbREi/80ih5+qwEq/ku70uTTK05Vl2QTJpxY+4T4rKAqD1TuuNXiT35jns2U/r0TVUEnWGFcdYpFDCr9ZAIA7e5or5NMq/mp4nV5V4XBPsGYMVko7XOgN20ohdoicK/0JE2MyYE7nWkdAnczOvNOjFLAMdD334qtrwQ2eR1BYpSr+ywhPJiHz2I6Y7W2Ovn4U9rrUf90A/jn2O76tTGG0/MCJGeM3uJjWqAGaW+X7V8t5BC7t7ldlNfbuDyj4Eiyo6VDsmIV6MW+J3ezAmGwpWtGFoIQr9RizkSHW2M5ckG30CZ4nxfugm08nRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28QrIu/G5gfHTcz1WHSYe/1n0BM8yUGaHK/6vDDHJz0=;
 b=lqHPMaXxT7bgzJHZ2KcJhURQGMTguR5E461bbzXEzd1a6E1tdy29GyiEpAWvHkK5oS0YHOd2nVF5vdoNmks3POc6qDOp2VCw4N0whzcLSW3AMNx3A2In9EFPbXctv0yCwY37EtvOx2BSxnWMgX+KqQer7xRt650Bg1d1EP6SzRogKBAOzeA/suQsyvkhrZDT4JIjleOwCQAW4TKgmx1eAeh4aQXnNH8c4JsumEJZL1ISPax+U7mPN6AuRl0uRpcJj3XuuJeHJmHG+mW2W3T1fQ3BgCxM7dROKRtc05pIyTeRu+neCmAEBhcp76EjhcFGzEUbmAXXZMcCAq2cdxtk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28QrIu/G5gfHTcz1WHSYe/1n0BM8yUGaHK/6vDDHJz0=;
 b=fyy/XmTaYofIXBnJCGTUeQ4Q/HrhUoIxWXuJhjRcEbLpGkILfOdg+w5fVL7L+UXbcrBzqu0BK+2tZ2e28DBCj1oe9S6H5JQwf6gXlqSDH8Ebjx8Lz//pIeQr2qjfSNFi6KICTmJW5FmnyVtvPsILvxQmV2ZDnUU3d3/HyPYTvqQ=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:52:07 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:52:07 +0000
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
Subject: [PATCH v3 10/12] Drivers: hv: vmbus: Clean up hv_sock channels by
 force upon suspend
Thread-Topic: [PATCH v3 10/12] Drivers: hv: vmbus: Clean up hv_sock channels
 by force upon suspend
Thread-Index: AQHVVvnf1EonI4zjtUyIq7VQGuCZSQ==
Date:   Tue, 20 Aug 2019 01:52:07 +0000
Message-ID: <1566265863-21252-11-git-send-email-decui@microsoft.com>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1566265863-21252-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0056.namprd21.prod.outlook.com
 (2603:10b6:300:db::18) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e719c36-9481-4ec8-4232-08d7251101c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB11333E5C751D2D91A77BBA73BFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(14444005)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(15650500001)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7p7FFjy0vuVoYzjxUP6/C3gFeeKuj+QsVVOhZ3pMl1motXPsm1NzkoQFD0MpMJj5+H5BPXHblO40FdLrDAV2qRWc+IK0x7bOBxegQZO5JU7ywB/H+hX72YKoLqTCTkb5bFPKE5d4Bb/9/RnSRXNoUrJJxvJHnp8Hl6OjaRVz4rDIncYpr24s51zFHZPWN+3fE7kwRgRqHwAcPO/bhVuKwlvTy15reCcgy5aMhzSI20c/1dteT9BbsURLYICavOEwLgNEWdEfd6rvxOaYfnW/UMi58buIYpp9/bQ+mYbWCOHjwdoleAVJqPdhJzvITnFljI6TVpYB3gcimhZOZmy/vkyH8rxI1IQTWg09qPTB5hp87kxHarh/U+ZfUbO7aPs606UC1PR6CJLc/FMHw7ZipNiyqb78Mx05NEQP7E1rN+o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e719c36-9481-4ec8-4232-08d7251101c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:52:07.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4l+rDhXU/ITfd+ohrK6yT+4y6jEGa8SCJRFtEFozLjgq/0rHug3w6qicnIJBjI44zuUcGg8BpAaT3O6+5Wzc+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fake RESCIND_CHANNEL messages to clean up hv_sock channels by force for
hibernation. There is no better method to clean up the channels since
some of the channels may still be referenced by the userspace apps when
hiberantin is triggered: in this case, the "rescind" fields of the
channels are set, and the apps will thoroughly destroy the channels
after hibernation.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index ce9974b..2bea669 100644
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
+		 * We wait here until any channel offer is currently
+		 * being processed.
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

