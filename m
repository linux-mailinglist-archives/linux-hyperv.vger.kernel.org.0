Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24DAAEE3
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 01:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403856AbfIEXBl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 19:01:41 -0400
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:14272
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391354AbfIEXB3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 19:01:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATiOpFE1WMDN0M0qKLetvCFqHlBRBoUCf78+QHwvDTvAh4G21Mti7b3k5bTfiVV0qd3yl07XtNnFCV7nDXABopucN+g8s65CsVn4hoo2wCjHmbwA+89P1prvdAHxs94Xf54kRPsGhhqyMWM05kOLqA59iFIVb9iln8a5NJWvH1mTB3jE3XeDdPgpkS/brhz2Wr8oVz/0YrHn+WInwyVBpfCRQfG7RZWyHRcM8A+h5MWWM31cMfr5Gubz7fNsrtX7jXUOYoA8JNvRk/XT7tAKukgzMa+7CnEdfIYLdYBKGkR9rC6RYGSLXoRXk0jTlwCc2zFzPkUi7vyzy4ZrBdBs6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yB6X7+2VJkyBW6oNR/EbjwmQgg90DjczJQ+/bX2nGI=;
 b=PkL684NQX2u/B5lFx2XHUv13LkFfWf/uc4S7jY8SMXd+4nTbqjEghlQbAP2imwGRaXHxkBLlikdfYpJY8r1+/9LbMh7W2vJS1gfYLd32URhDWLGVn6Y2wiSMcLusAPe/Yl9AmuW0DYq1oMPozcaxRozf4QpCrkRwivtV+5NTkhvx7lzwFbN9iib/bM/ltkqOMELLH59Ow1zHoA/CR8jAVOPHX5zrfyUKw8ayklNiXpE3VHRjifMlsdXQA1XJap6S0KFT4R5GjMSiHl7BVu6AhqX1wghvyaF1FfBpNYl/ztIVDaQpBh3txawyZcdegzv8L+mFrv6jt8jVF6cnfIvJ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yB6X7+2VJkyBW6oNR/EbjwmQgg90DjczJQ+/bX2nGI=;
 b=R27+hLo4onVIUlQ7kQh22tHD7DW3Ms+hJphM8msii4vDr0cw3RgS/qochganKvNW8AgKIt3mxIR1MV19nS+1TX9qLRY5n/Zn8XplxDKuxyC4wHREQhId0Vd+ciQ7YP+J+yUh6alhwkfbt1Jg4Y6GfB9HnOgZpztRQ5UqitV+8gE=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1038.namprd21.prod.outlook.com (52.132.115.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Thu, 5 Sep 2019 23:01:20 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 23:01:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 7/9] Drivers: hv: vmbus: Clean up hv_sock channels by force
 upon suspend
Thread-Topic: [PATCH v5 7/9] Drivers: hv: vmbus: Clean up hv_sock channels by
 force upon suspend
Thread-Index: AQHVZD3UDJ5Ee+Jj1EOBY7edNwplCg==
Date:   Thu, 5 Sep 2019 23:01:20 +0000
Message-ID: <1567724446-30990-8-git-send-email-decui@microsoft.com>
References: <1567724446-30990-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567724446-30990-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:301:73::25) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f74d275b-910c-42fc-e1c2-08d73254f73d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1038;
x-ms-traffictypediagnostic: SN6PR2101MB1038:|SN6PR2101MB1038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB10380724F3A0A7242807E348BFBB0@SN6PR2101MB1038.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(6506007)(66446008)(256004)(14444005)(10290500003)(478600001)(476003)(102836004)(186003)(36756003)(52116002)(64756008)(71200400001)(26005)(11346002)(3450700001)(6512007)(71190400001)(305945005)(15650500001)(107886003)(4326008)(446003)(66946007)(316002)(76176011)(7736002)(6436002)(66556008)(386003)(22452003)(66476007)(6486002)(486006)(53936002)(2616005)(25786009)(14454004)(54906003)(110136005)(5660300002)(2501003)(3846002)(2906002)(6116002)(81156014)(8676002)(81166006)(86362001)(50226002)(4720700003)(66066001)(10090500001)(1511001)(99286004)(8936002)(43066004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1038;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XBhwcdTtO1mnGhql7BFUIpX3jsgbWxAC726EZzsD2LLkj+paYMpsDdGsi165SHo3+U5WrO7dInAa754hJ6xVQ5/zA8yNHcK2NiIcn9ZeaseqD3ycej/k8Zh6gO1e2LRzaKWi5WJ5zN/cTouTWdQimRbcUQABTWFeIt2eN7gghrKmhAlSkcaHoPNACFTk+F9KWWC/QRcCcIndODlt21+WRQZGZWaZmnFvJIVFDrjnUdxw1xiqYxskp2gf6cn0ryuDaprp31URtMa7RR44oqqx3JaPaTa+nAJ1cQUE8QcD/ZS8lT2W7HOXhoFoM9rqN9bek0BKPl5fmEsZhc9RzQ5BvpD4UowKbWBKAO+7M/YXS0LJPpSB70x1h+4objhpclQxyeb2SUOfn3oe2n52QI/T5M9KzB3Eg5ecnN72SwX68D8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74d275b-910c-42fc-e1c2-08d73254f73d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:01:20.5002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrQg2O6VaWAfEHz6t6ouDIBbcCQdTEixbJ/6EAn9FIWiTZemETLNGPWITZX3JdcSMnd18Uo7XYdK5qa93mdmPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1038
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

