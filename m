Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B190AB0605
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfIKXi0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:38:26 -0400
Received: from mail-eopbgr690132.outbound.protection.outlook.com ([40.107.69.132]:35718
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfIKXiZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:38:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTGaRGIoroQHCrMM+im3dHbi3JXEulZqO4kTICvgeZBvnwcMBRn+hSrCfRD8CbrS+I7NXlANfQzYuMcpxbsSU0qV5++wotWQXRtngp30Zhz7mMA4QfEsNYw33zFj9IEnBAjDQoeSQs9XrGYXv0nh7c19jOskqbctGFJyENH39SN8sjyHKCHT/bKY5cisPHEiiPrwWNvb0sZnxUx5tsWtwxOyIgQHHiamX/enAunVJZ+wHMX1Ev+HPtSjxnPvzzwOkQZuDVGlFcJtaySN/tA3LoA2bTGzzrQI8B064FrdF3BxddvPDbgtnc3DmnoGpkiylcjNgf3qlAV1YKgLsZgAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9Vln3Esilvf0BzlbdluiKamT5+ViS25EX8eBAg/Jss=;
 b=j6AQ95JwRuRHaFwrTqeQ/xQiLXcnr7fLlqVxiZVCSVjXNiJL7oSE2x2VkE/F2YR/As8bCkpC4fNfRCf0Q/8yzL070UI6GhBf4SPE0P7ktNh0oPZEPYfpwxZEFU1kx6za5nw4pHMtOachtVSfWqxlzau70H03J8W4Zs+swcsZHXKrSoUhdqawVs3VOWrhxfYUtrREZpcKeRzg06pAJq+ss/9IY7g+0l+tWNstt6vgM7e96TmELJO77w41tjfdcHxaEYyenlqrRScYWmrlN1Qtc9vXnuaW6IvcwYw1pv1xC62YRT0m4sXNdyTUJEXq3o27CX2n7GfFyXuyRRwFSG2lWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9Vln3Esilvf0BzlbdluiKamT5+ViS25EX8eBAg/Jss=;
 b=PaJVMpsSDg8C/IjCkoKFkySSDX7bURW9EdlUzh78FYNRzj+nzOIt7lJX2Ml0CdZijfxTsbzN6BwoUWDFNCpyOWrCIXXpl8RSN6e7yO2Hr6hcZx0lkoFbdruquYSjbl243wb9NaynBfQM0ddXLkeNsfdKdyRtghtOP38wfTk1xB8=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1087.namprd21.prod.outlook.com (52.132.115.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.7; Wed, 11 Sep 2019 23:38:20 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:38:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 2/4] PCI: hv: Add the support of hibernation
Thread-Topic: [PATCH 2/4] PCI: hv: Add the support of hibernation
Thread-Index: AQHVaPn+DI+GUCWMB0+XXf/yIGJHbQ==
Date:   Wed, 11 Sep 2019 23:38:20 +0000
Message-ID: <1568245086-70601-3-git-send-email-decui@microsoft.com>
References: <1568245086-70601-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1568245086-70601-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0072.namprd19.prod.outlook.com
 (2603:10b6:300:94::34) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee158937-7278-4e47-c733-08d7371120d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1087;
x-ms-traffictypediagnostic: SN6PR2101MB1087:|SN6PR2101MB1087:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB108700F7B410B1263F6CB424BFB10@SN6PR2101MB1087.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(10290500003)(11346002)(2201001)(2501003)(256004)(7736002)(6436002)(305945005)(2906002)(14454004)(3846002)(2616005)(81156014)(81166006)(8936002)(50226002)(66066001)(26005)(8676002)(5660300002)(110136005)(6116002)(316002)(6512007)(66556008)(186003)(66946007)(86362001)(446003)(66446008)(6486002)(64756008)(66476007)(22452003)(71200400001)(476003)(71190400001)(107886003)(43066004)(25786009)(478600001)(14444005)(102836004)(6636002)(99286004)(1511001)(36756003)(4326008)(486006)(76176011)(53936002)(52116002)(3450700001)(6506007)(386003)(4720700003)(10090500001)(21314003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1087;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QuTtAVzF4IzsT9/AML/9Lgu1js1fc0vB8AXvkE2Njs58mpGv4etirziCZcS2KoZcu6OZ/SILCE+dfow5ELS2j2EK2ldyT9oUTjAlE0Ga5+EXs0lNazTzXewx7UVb8mVFvx3sdCI0N059AhnftO9wg/k+Fzi3XTj1bdhnClMAJyxCXNkLIKP7erRhFnx1IIBNpkdq+O+DEHaUIBLXLQ2kVHGdNHv6kqPJboFcULqPaoaWaYaXBozpI0Z/9VD170h6HmHeQcsjCc4CrvnOtz33UGSpBK0hi5hrMVshdafCl27pDMziQ9pQ+uRWV6Yi7rtLDYgLP1g4ywa4Eedexcp0pRazYbGZqeyVcsoL3Y4SG6UKPT83tSH5GYqjEpK5gfkMhEQhrW3Jp2DuDz4EUB/XJUHsF0Pueb6kI6wbS8ev0Aw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee158937-7278-4e47-c733-08d7371120d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:38:20.3484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 664EO/hRa6rCP40JGdUz1jgo5g+NZopQlDIlSOyvssUmRuue1ePPNip4gMnP1RJXJLB7qW0mg9/2c7qmFREUsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1087
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement the suspend/resume callbacks for hibernation.

hv_pci_suspend() needs to prevent any new work from being queued: a later
patch will address this issue.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 76 +++++++++++++++++++++++++++++++++=
++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 03fa039..3b77a3a 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1398,6 +1398,23 @@ static void prepopulate_bars(struct hv_pcibus_device=
 *hbus)
=20
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
=20
+	/*
+	 * Clear the memory enable bit, in case it's already set. This occurs
+	 * in the suspend path of hibernation, where the device is suspended,
+	 * resumed and suspended again: see hibernation_snapshot() and
+	 * hibernation_platform_enter().
+	 *
+	 * If the memory enable bit is already set, Hyper-V sliently ignores
+	 * the below BAR updates, and the related PCI device driver can not
+	 * work, because reading from the device register(s) always returns
+	 * 0xFFFFFFFF.
+	 */
+	list_for_each_entry(hpdev, &hbus->children, list_entry) {
+		_hv_pcifront_read_config(hpdev, PCI_COMMAND, 2, &command);
+		command &=3D ~PCI_COMMAND_MEMORY;
+		_hv_pcifront_write_config(hpdev, PCI_COMMAND, 2, command);
+	}
+
 	/* Pick addresses for the BARs. */
 	do {
 		list_for_each_entry(hpdev, &hbus->children, list_entry) {
@@ -2737,6 +2754,63 @@ static int hv_pci_remove(struct hv_device *hdev)
 	return ret;
 }
=20
+static int hv_pci_suspend(struct hv_device *hdev)
+{
+	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
+	int ret;
+
+	/* XXX: Need to prevent any new work from being queued. */
+	flush_workqueue(hbus->wq);
+
+	ret =3D hv_pci_bus_exit(hdev, true);
+	if (ret)
+		return ret;
+
+	vmbus_close(hdev->channel);
+
+	return 0;
+}
+
+static int hv_pci_resume(struct hv_device *hdev)
+{
+	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
+	enum pci_protocol_version_t version[1];
+	int ret;
+
+	hbus->state =3D hv_pcibus_init;
+
+	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
+			 hv_pci_onchannelcallback, hbus);
+	if (ret)
+		return ret;
+
+	/* Only use the version that was in use before hibernation. */
+	version[0] =3D pci_protocol_version;
+	ret =3D hv_pci_protocol_negotiation(hdev, version, 1);
+	if (ret)
+		goto out;
+
+	ret =3D hv_pci_query_relations(hdev);
+	if (ret)
+		goto out;
+
+	ret =3D hv_pci_enter_d0(hdev);
+	if (ret)
+		goto out;
+
+	ret =3D hv_send_resources_allocated(hdev);
+	if (ret)
+		goto out;
+
+	prepopulate_bars(hbus);
+
+	hbus->state =3D hv_pcibus_installed;
+	return 0;
+out:
+	vmbus_close(hdev->channel);
+	return ret;
+}
+
 static const struct hv_vmbus_device_id hv_pci_id_table[] =3D {
 	/* PCI Pass-through Class ID */
 	/* 44C4F61D-4444-4400-9D52-802E27EDE19F */
@@ -2751,6 +2825,8 @@ static int hv_pci_remove(struct hv_device *hdev)
 	.id_table	=3D hv_pci_id_table,
 	.probe		=3D hv_pci_probe,
 	.remove		=3D hv_pci_remove,
+	.suspend	=3D hv_pci_suspend,
+	.resume		=3D hv_pci_resume,
 };
=20
 static void __exit exit_hv_pci_drv(void)
--=20
1.8.3.1

