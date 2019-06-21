Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF124F142
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Jun 2019 01:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFUXpd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Jun 2019 19:45:33 -0400
Received: from mail-eopbgr1320138.outbound.protection.outlook.com ([40.107.132.138]:32576
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfFUXpc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jun 2019 19:45:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjwrGg2s9Xkh6InlTVThd/VKU38hHLaw7JqrO9XGd2VMhHDrN2wWWkDELFdAxvzTio4SM8jg0rDrQ+2SQL0KT9mwK6nknY7oO/IGokm0P1Wr/d+7lzRwaF1kxn4dW3HOwEYY6B3ifVTSe0scsvzFzqYRbTkrUd/b6xj8V1CWOha4Eej8e4dW6qF/uCNAzyr2S5uQU4p4fy2VqWsjT7fbMEixR6ApyQkXRbVn2ODie5zoCoGNCSpxexj8+Zg81jEzLO9B1orXidS+NYX82ypMSAHD/5F9vOePJzCLP4ibKX+zm8373LrMK64ahe0BSPs3QYLo3pRxvycM6AFHxxsrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8CWWd7MC4BsydFkUj2lYF9hVLNH28nJybcBiGbdv2g=;
 b=lBhGWiXCVqVMB/wDU+6hY3D+zoCDVQuQ7E86CL3DC9VJhlea7NnsEbKOSt2uo5RBidFTkCwd9psE8OKQevpM4iLv7HZNHChxeVpZ3nUXWXD91FdJMwIJyR+IPmJy0Qk0bPxE/p/PTtahqC2CaeFfOtSRDCOatfIhqg8WfoAmlMeK8+Z0u4h7tZHxtTvS9m4AlMkDxWScnEqes2xrArEWEQaOhDPexslu2PlnFGpHBNrVduVSuVwKFnpyKpxpKMQ8rcAyrHZ9Xeq3rHQvA7eKH5SFuYUwHbCJbgMuyrlcR7JzLGFKKh7DqK2HGqgipLYddZnZzGe39zhs+3K9ZAncKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8CWWd7MC4BsydFkUj2lYF9hVLNH28nJybcBiGbdv2g=;
 b=dq4amyJMp9vVvWx2h3eaFGrl+9RWmIY/mHkm1uVxSfbjz23EjgwD85CwWjFDRboqeie35v2DBcn+XaC9kxpuRXPsWyxw459tcSnBYNqeHKeVsqWan2XLg/czJWMpu7VvLOCpKT/NvVEWObYKZHmr1xoJcGb4RHbIPW+ne2M7IZc=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0154.APCP153.PROD.OUTLOOK.COM (10.170.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.7; Fri, 21 Jun 2019 23:45:24 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::19b8:f479:a623:509b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::19b8:f479:a623:509b%5]) with mapi id 15.20.2032.008; Fri, 21 Jun 2019
 23:45:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "Lili Deng (Wicresoft North America Ltd)" <v-lide@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Subject: [PATCH v2] PCI: hv: Fix a use-after-free bug in
 hv_eject_device_work()
Thread-Topic: [PATCH v2] PCI: hv: Fix a use-after-free bug in
 hv_eject_device_work()
Thread-Index: AdUoio+jbgfPCntMRSGnwgYrj5f2ww==
Date:   Fri, 21 Jun 2019 23:45:23 +0000
Message-ID: <PU1P153MB0169D420EAB61757DF4B337FBFE70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-21T23:45:19.8774766Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=19ebd965-88c8-4bcc-b3cf-e659d74e2b95;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:3a2e:2bcf:5c00:8eef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0b9959c-c694-4013-b877-08d6f6a287a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0154;
x-ms-traffictypediagnostic: PU1P153MB0154:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01540E3EA920FB20015859B7BFE70@PU1P153MB0154.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(66476007)(10090500001)(4326008)(76116006)(486006)(6436002)(9686003)(8990500004)(256004)(1511001)(186003)(55016002)(2906002)(33656002)(2501003)(102836004)(14444005)(6506007)(66556008)(86362001)(476003)(2201001)(64756008)(46003)(73956011)(66446008)(10290500003)(71190400001)(71200400001)(99286004)(25786009)(7696005)(66946007)(53936002)(81166006)(7416002)(8676002)(7736002)(81156014)(8936002)(110136005)(22452003)(74316002)(54906003)(316002)(6116002)(52536014)(14454004)(305945005)(5660300002)(478600001)(6636002)(68736007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0154;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AJfZrJWfaXGjG0pGAE4ARG/bnVS5B7bBQT6YyVNNjyZO7chHKRYP50v1CkhFZohxeNUe9RNkibYyiGIQDB7Jut6HoDcxLp2ZvkZ9JO4U507biwU0bqSgNWGo/WwZX3ghHquTwND+rNmb8oprcm2Eej1ofnIfBDnx6J+1LiofU9lp6xsmEnro7V/HwS/2wDHeC0n/CGimSDwoCaWnvFPa/FqQbapPXXOWiJ3yt1QhvK7Hc1EF03R8cj24elmWs7b0wjWQsLbeFa9BYvksvRIBv+lYNoPIeJZvesQAyPuDyqb8oQWKop8b1+KKgxOn/caPvmh2lbNWeMc/ZT6+bYKEHy7T24MeH+892e17BvFWyPCCygD83FtZtUCfCIKgPI/ymTjvMsLl9nkdIVB+MVQmiWZXCwxS5/t2fSKYRiB1KEw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b9959c-c694-4013-b877-08d6f6a287a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 23:45:23.5656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0154
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


The commit 05f151a73ec2 itself is correct, but it exposes this
use-after-free bug, which is caught by some memory debug options.

Add a Fixes tag to indicate the dependency.

Fixes: 05f151a73ec2 ("PCI: hv: Fix a memory leak in hv_eject_device_work()"=
)
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
---

In v2:
Replaced "hpdev->hbus" with "hbus", since we have the new "hbus" variable. =
[Michael Kelley]

 drivers/pci/controller/pci-hyperv.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 808a182830e5..5dadc964ad3b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1880,6 +1880,7 @@ static void hv_pci_devices_present(struct hv_pcibus_d=
evice *hbus,
 static void hv_eject_device_work(struct work_struct *work)
 {
 	struct pci_eject_response *ejct_pkt;
+	struct hv_pcibus_device *hbus;
 	struct hv_pci_dev *hpdev;
 	struct pci_dev *pdev;
 	unsigned long flags;
@@ -1890,6 +1891,7 @@ static void hv_eject_device_work(struct work_struct *=
work)
 	} ctxt;
=20
 	hpdev =3D container_of(work, struct hv_pci_dev, wrk);
+	hbus =3D hpdev->hbus;
=20
 	WARN_ON(hpdev->state !=3D hv_pcichild_ejecting);
=20
@@ -1900,8 +1902,7 @@ static void hv_eject_device_work(struct work_struct *=
work)
 	 * because hbus->pci_bus may not exist yet.
 	 */
 	wslot =3D wslot_to_devfn(hpdev->desc.win_slot.slot);
-	pdev =3D pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain, 0,
-					   wslot);
+	pdev =3D pci_get_domain_bus_and_slot(hbus->sysdata.domain, 0, wslot);
 	if (pdev) {
 		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(pdev);
@@ -1909,9 +1910,9 @@ static void hv_eject_device_work(struct work_struct *=
work)
 		pci_unlock_rescan_remove();
 	}
=20
-	spin_lock_irqsave(&hpdev->hbus->device_list_lock, flags);
+	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	list_del(&hpdev->list_entry);
-	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
+	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
=20
 	if (hpdev->pci_slot)
 		pci_destroy_slot(hpdev->pci_slot);
@@ -1920,7 +1921,7 @@ static void hv_eject_device_work(struct work_struct *=
work)
 	ejct_pkt =3D (struct pci_eject_response *)&ctxt.pkt.message;
 	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
 	ejct_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
-	vmbus_sendpacket(hpdev->hbus->hdev->channel, ejct_pkt,
+	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
 			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
 			 VM_PKT_DATA_INBAND, 0);
=20
@@ -1929,7 +1930,9 @@ static void hv_eject_device_work(struct work_struct *=
work)
 	/* For the two refs got in new_pcichild_device() */
 	put_pcichild(hpdev);
 	put_pcichild(hpdev);
-	put_hvpcibus(hpdev->hbus);
+	/* hpdev has been freed. Do not use it any more. */
+
+	put_hvpcibus(hbus);
 }
=20
 /**
--=20
2.17.1

