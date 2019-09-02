Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20F9A5E05
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 01:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfIBXPF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 19:15:05 -0400
Received: from mail-eopbgr1300113.outbound.protection.outlook.com ([40.107.130.113]:60252
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfIBXPE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 19:15:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PijwKdqyp48II2nshjMjYlr9iEKaayvF1NoLHR4PA6s5wD46eoIVU98FfWCESPUaDW8hIgY0o0FiE0HLXc04MKwpoK1xfSJcZOYCby/4nrMtP3HF2McPpDTY7lgoslBKX7RdWzvEyPCamQTEPVqqXKB4Gu5uSVBbMmQY4CKES1kXIYD8SVbJ3mN2FoE32mjlhK5pxPtlcXZP4qR4e+ofEXOFFrylsT+UJM1fpZFXg7l1eM0lt3LLoTr1lsXc249I0fF4/00/ZE7lr6vTAWZlDvCzXRtYbfEAjFdqphhX860Tjc407eZ5QlPyr22qekBxp5Ng9OCjJt/vaYK3m8ar7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ntnqllTt7c12TfQkWnPeR91zVuZKwQJlKPYnI8VM/Q=;
 b=Rb3ejL4IwHjgpIrUmLJmH2qBMhfV9wRwmvAQqQ3eUD8/++d4qqLuUsirj/l9Bm86A4J/kPX+1BoEqwlZ/ZIatk1taCu0/Djoj7S+ztj2qO5cc6iNJ7+N+70XKf51XOHpLrVmN1JEj3avQE53RqzlkpV1P3/N+zmvG7HPxoX4P9VLhCaLIAsRdMcq/JUqRp1/aWpPPCjiaHdDXveD2qgxkqCC7LVBkwuNrSIDFstp7cguDE6W9xORQyLJl4H/hcsv6tp1Tt1MEEZolu0KevGOZxNvyfOFDVsWM9b6O+ZL5jmAegv8NJBvxDVElgWfOzjfOwFnnByYAUmt7ixrBDUFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ntnqllTt7c12TfQkWnPeR91zVuZKwQJlKPYnI8VM/Q=;
 b=OXGCaKGwEc7I87L88lmqu7BNJoqvOKeu1mMK8snP+0KJi+/SZJfpwxVM8bjXQyW1MZ1ZNorPMbOELIojz3q+fOfIlTgvwh+oBO4tM5DZ6ZxjjNO+PL7WtRXX4ljp8HWR6xGwZTn7tlNZbst/w6/w9qCPKmye5z9WJ1EbqE9/fdY=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0107.APCP153.PROD.OUTLOOK.COM (10.170.188.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Mon, 2 Sep 2019 23:14:57 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2241.013; Mon, 2 Sep 2019
 23:14:57 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lili Deng (Wicresoft North America Ltd)" <v-lide@microsoft.com>
Subject: [PATCH] irqdomain: Add the missing assignment of domain->fwnode for
 named fwnode
Thread-Topic: [PATCH] irqdomain: Add the missing assignment of domain->fwnode
 for named fwnode
Thread-Index: AdVh4blqLc5rFg83RpSOwiBFpYO6dw==
Date:   Mon, 2 Sep 2019 23:14:56 +0000
Message-ID: <PU1P153MB01694D9AF625AC335C600C5FBFBE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-02T23:14:54.7798798Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=27b9a0ce-4761-494d-81f6-46ffd0132acf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:45b3:904b:db76:f1a7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e928531-0e80-427a-4f8b-08d72ffb5ee3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0107;
x-ms-traffictypediagnostic: PU1P153MB0107:|PU1P153MB0107:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB010769251CAA7B0372E026F0BFBE0@PU1P153MB0107.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(54534003)(46003)(478600001)(10090500001)(14454004)(8990500004)(66946007)(66476007)(66556008)(66446008)(64756008)(10290500003)(305945005)(7736002)(99286004)(52536014)(81156014)(8936002)(74316002)(110136005)(8676002)(81166006)(7696005)(316002)(22452003)(102836004)(186003)(6506007)(107886003)(4326008)(53936002)(2906002)(54906003)(6116002)(5660300002)(86362001)(76116006)(6436002)(476003)(256004)(9686003)(71200400001)(55016002)(71190400001)(486006)(33656002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0107;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XkfGkx+csX2pbXED7D2Sy4fTmfq/tUx0Reh2fCVtPAVyT8V+p/kYqWlmZTM/UBA/VYXd/KSVwjkdFW56du4AY9hq+25fSj+1SOdWgPgsiDLhOSSuLY3qztT+194ESPhnEOJ0rCvdSCdnDOCmVoe9dMOA8iH7Q/iBKv3H/QxZnskNZO4Uo0ssUi+0Vn9Shy0/AT+OJpBhAUfCnlmHTLxG3117jpGmfNnU7vGrgrUa64VoOvK0cbCmThIJC7jNUKOB7YdkI6xR3tSbn4YEwXpl+4HaUxCrSxuyNUF3TpXIJVp3MeoQcW4IJt8W/HWte5j6Q/gqEK4ZOn1qS3cWl00C+6Sc0cs2fNvDsSf2LUpgT8fzIlg7UhctxlbyRctPubaK5g5BSo0zK5MNLJWzGnQnVU0HByYfJtP57MWS2rzGqz8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e928531-0e80-427a-4f8b-08d72ffb5ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 23:14:56.6849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imf/ngyJCN3NgQC9J9zXVl8t+2lzAclZ0psn7nf7nXVpmxW7y6jYZkE3xsjVv5NwNVd30QGd+F05JW07K7ZZFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0107
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Recently device pass-through stops working for Linux VM running on Hyper-V.

git-bisect shows the regression is caused by the recent commit
467a3bb97432 ("PCI: hv: Allocate a named fwnode ..."), but the root cause
is that the commit d59f6617eef0 forgets to set the domain->fwnode for
IRQCHIP_FWNODE_NAMED*, and as a result:

1. The domain->fwnode remains to be NULL.

2. irq_find_matching_fwspec() returns NULL since "h->fwnode =3D=3D fwnode" =
is
false, and pci_set_bus_msi_domain() sets the Hyper-V PCI root bus's
msi_domain to NULL.

3. When the device is added onto the root bus, the device's dev->msi_domain
is set to NULL in pci_set_msi_domain().

4. When a device driver tries to enable MSI-X, pci_msi_setup_msi_irqs()
calls arch_setup_msi_irqs(), which uses the native MSI chip (i.e.
arch/x86/kernel/apic/msi.c: pci_msi_controller) to set up the irqs, but
actually pci_msi_setup_msi_irqs() is supposed to call
msi_domain_alloc_irqs() with the hbus->irq_domain, which is created in
hv_pcie_init_irq_domain() and is associated with the Hyper-V chip
hv_msi_irq_chip. Consequently, the irq line is not properly set up, and
the device driver can not receive any interrupt.

Fixes: d59f6617eef0 ("genirq: Allow fwnode to carry name information only")
Fixes: 467a3bb97432 ("PCI: hv: Allocate a named fwnode instead of an addres=
s-based one")
Reported-by: Lili Deng <v-lide@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Note: the commit 467a3bb97432 ("PCI: hv: Allocate a named fwnode ...") has =
not
gone in Linus's tree yet (the commit is in linux-next for a while), so the =
commit ID
in the changelog can change when it goes in Linus's tree.

This patch works in my test, but I'm not 100% sure this is the right fix.=20

Looking forward to your comment!

 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e7bbab149750..132672b74e4b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -149,6 +149,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handl=
e *fwnode, int size,
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
+			domain->fwnode =3D fwnode;
 			domain->name =3D kstrdup(fwid->name, GFP_KERNEL);
 			if (!domain->name) {
 				kfree(domain);
--=20
2.19.1

