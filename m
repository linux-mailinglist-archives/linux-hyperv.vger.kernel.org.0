Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A609953CA
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfHTBwM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:12 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:42832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729009AbfHTBwL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbHsdtxlJ3TkMUTliPF9LQv3C3MSpdMcTPDa9jJv6dIRC6YKT+C32BgmoQzY7lfZWBugd019XyZBhgsvFsuOKOOyXOGAhgSzfGOLoa543SlZLR2p5CkinFLQfeFdXOqiIRDejux4u2KkSOB1nxa85rZlFc0nbyDwm7no5CexSQ0q2lUbbd3jII8Urmt0Hluxt5rycUEsjFQMF2uLAmQm/F0FQYz1xeJGcROHcbU7qfG0uZIT445Jl/Hy9Re9j+vzI3nKBKQBJndlCtL3XCv9hF2LCsHkUTpe/H11JqhNZByM2z46sD0xkdAzMibITXxjEUExTIAdy9jeyRdArcxlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxqiUKJu4cVovwkdpzuCUjeVgsQyaH7mMWf0ksMp1To=;
 b=kbn9BSO1Sd9Xn5KBrFpif2ZCQ0Jlp1wXG0bDzZDLdyy68TE42IeL/HUAkQsHGf14XrTdUEy43B78zz5wCQ6FOI14QnSNboZsde7Fref7GZ0Yh9Mi1LNx8OLFTPeBwtsyepwm6MtTzL/Bdf6xpNq7lAmWXE/Dp+uMsrZ6+tESaqX2hnuekGBBunqCgGlfK6f7ZceF6yGncFLTnrjc2/MgECuCuyHJqSUT/6R3H1FYpio5Yx1L/cO27aIdotHW19ZWzsJ2mVjdGFee/dAZkW4f0sV0qPSDvNqPfejgqoDVBHTNfsVA7Go2vxwHTSKPtlSDDIAiUKmFfzzq+hI/D8laEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxqiUKJu4cVovwkdpzuCUjeVgsQyaH7mMWf0ksMp1To=;
 b=WfvAQOCegVAGUMkuqmjT/osrYN5F+IJpgotCljug2uOdqJyRa9VFLsNXYeDT+LnDxg9icSzx6hlMUf/KdD//kj3MNlq+4fJbdvNw3j6B0n4GyFmuhfZ9oAFUtRwRr1BRYaQa0XGNAnIYBUXQ53VPvLqkcSA5qehhTZn8aVW7xd4=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:52:06 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:52:06 +0000
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
Subject: [PATCH v3 09/12] Drivers: hv: vmbus: Suspend/resume the vmbus itself
 for hibernation
Thread-Topic: [PATCH v3 09/12] Drivers: hv: vmbus: Suspend/resume the vmbus
 itself for hibernation
Thread-Index: AQHVVvne25Gm5tsm+EaoeGWX1gniVA==
Date:   Tue, 20 Aug 2019 01:52:06 +0000
Message-ID: <1566265863-21252-10-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 1b12fee6-872f-4078-0a5b-08d725110101
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1133B3DFB72EA4B5E9C3A619BFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(14444005)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(15650500001)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VbTMGgr77zW4a7suE3r0irX1WjV7FK4fUGSDcQA3KdStrrDwEExVXODLZ55uInGgoDfB45bZrYxYPEtQiCpayrWSO2OlUDOeImQJc2Fe9zCuQ1iy8zj8f0V4zpgMCMcgk+lhxwVC1i9ErIBfPyN+91UdLAfYXrme8F5VXeHDkJfM00Z/p/pRoaKusyj9zbnI4Xir1rmO1p0o7h6WApCdXv5I3EDQoIYoSwmF+ll/T7yfw3VWxEweIod6T5UhjZR/bEMktgGY+CXCD++6hZ7jqnP+N36tFP2czzNxr+974emWqxoyaAy4IjT3kZmoW9ZwskWpWJC42e9xUIf6FqCE6DnJJ0QNUSNhdN+9kA59zy4sRE8XmhH+livtF5aA+folzTQM5R4wcS5DwZfpc0MAL4GvVevVJAhZ+dD7b6xw15o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b12fee6-872f-4078-0a5b-08d725110101
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:52:06.2807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8ZH75LeiXsY+HCc4eoSejXUH8oCa2J89uJEPFMivfBt5cpj50Bgjg2YROw+ew56T/+sD/z2nJod9FEiTDJ5Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Before Linux enters hibernation, it sends the CHANNELMSG_UNLOAD message to
the host so all the offers are gone. After hibernation, Linux needs to
re-negotiate with the host using the same vmbus protocol version (which
was in use before hibernation), and ask the host to re-offer the vmbus
devices.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/connection.c   |  3 +--
 drivers/hv/hyperv_vmbus.h |  2 ++
 drivers/hv/vmbus_drv.c    | 59 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 6c7a983..701d9a8 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -59,8 +59,7 @@ static __u32 vmbus_get_next_version(__u32 current_version=
)
 	}
 }
=20
-static int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo,
-					__u32 version)
+int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 ver=
sion)
 {
 	int ret =3D 0;
 	unsigned int cur_cpu;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index c42b46d..4610277 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -272,6 +272,8 @@ struct vmbus_msginfo {
=20
 extern struct vmbus_connection vmbus_connection;
=20
+int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 ver=
sion);
+
 static inline void vmbus_send_interrupt(u32 relid)
 {
 	sync_set_bit(relid, vmbus_connection.send_int_page);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a30c70a..ce9974b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2089,6 +2089,51 @@ static int vmbus_acpi_add(struct acpi_device *device=
)
 	return ret_val;
 }
=20
+static int vmbus_bus_suspend(struct device *dev)
+{
+	vmbus_initiate_unload(false);
+
+	vmbus_connection.conn_state =3D DISCONNECTED;
+
+	return 0;
+}
+
+static int vmbus_bus_resume(struct device *dev)
+{
+	struct vmbus_channel_msginfo *msginfo;
+	size_t msgsize;
+	int ret;
+
+	/*
+	 * We only use the 'vmbus_proto_version', which was in use before
+	 * hibernation, to re-negotiate with the host.
+	 */
+	if (vmbus_proto_version =3D=3D VERSION_INVAL ||
+	    vmbus_proto_version =3D=3D 0) {
+		pr_err("Invalid proto version =3D 0x%x\n", vmbus_proto_version);
+		return -EINVAL;
+	}
+
+	msgsize =3D sizeof(*msginfo) +
+		  sizeof(struct vmbus_channel_initiate_contact);
+
+	msginfo =3D kzalloc(msgsize, GFP_KERNEL);
+
+	if (msginfo =3D=3D NULL)
+		return -ENOMEM;
+
+	ret =3D vmbus_negotiate_version(msginfo, vmbus_proto_version);
+
+	kfree(msginfo);
+
+	if (ret !=3D 0)
+		return ret;
+
+	vmbus_request_offers();
+
+	return 0;
+}
+
 static const struct acpi_device_id vmbus_acpi_device_ids[] =3D {
 	{"VMBUS", 0},
 	{"VMBus", 0},
@@ -2096,6 +2141,19 @@ static int vmbus_acpi_add(struct acpi_device *device=
)
 };
 MODULE_DEVICE_TABLE(acpi, vmbus_acpi_device_ids);
=20
+/*
+ * Note: we must use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS rather than
+ * SET_SYSTEM_SLEEP_PM_OPS, otherwise NIC SR-IOV can not work, because the
+ * "pci_dev_pm_ops" uses the "noirq" callbacks: in the resume path, the
+ * pci "noirq" restore callback runs before "non-noirq" callbacks (see
+ * resume_target_kernel() -> dpm_resume_start(), and hibernation_restore()=
 ->
+ * dpm_resume_end()). This means vmbus_bus_resume() and the pci-hyperv's
+ * resume callback must also run via the "noirq" callbacks.
+ */
+static const struct dev_pm_ops vmbus_bus_pm =3D {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(vmbus_bus_suspend, vmbus_bus_resume)
+};
+
 static struct acpi_driver vmbus_acpi_driver =3D {
 	.name =3D "vmbus",
 	.ids =3D vmbus_acpi_device_ids,
@@ -2103,6 +2161,7 @@ static int vmbus_acpi_add(struct acpi_device *device)
 		.add =3D vmbus_acpi_add,
 		.remove =3D vmbus_acpi_remove,
 	},
+	.drv.pm =3D &vmbus_bus_pm,
 };
=20
 static void hv_kexec_handler(void)
--=20
1.8.3.1

