Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7A4F1CC
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Jun 2019 01:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfFUX6c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Jun 2019 19:58:32 -0400
Received: from mail-eopbgr690102.outbound.protection.outlook.com ([40.107.69.102]:57830
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbfFUX6b (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jun 2019 19:58:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVRurj1VE6bIlEYKh/9YUDDWUcO2xQO4XP13I1T0FXb4T/8f89xZpobD31PxZK9FeCsMGlNi0PMfE9Lgy0sOccXo0kvFxpxC18mY97HKnOItenEm7SBQScSJQywAR/aAk8rhizi6GCsZF9823n50FM7+wlGJYTTsrW67cAX/7spwRGNWVT+/Dty5XvQ+rMQ1K4bu0CvW/tixTn2ukfrl8xGHFTWL6g2CGrLmrtttIqalpDCeVX9Umn2S9xoOrsKtxkR37EBa6C2PndKq+jrcYTcnENrq8N7Ug6AxEp7hqMmntEWP5RDPt6Rd9KuNBuO/bxKbyU6PaFIO7jM4BXxwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixRMS1d82hbBKPn8wCLKDfizqvxiFmMGfWx1FYWcbzI=;
 b=awXKCOKEHymMW46QqNnauLijq1vF++aoqwvoIRkYzbjhG8CKNcuSrJk//PFtf9tvnwOlTaShB8B6Elocd4HgPl3Z7sYON+n244pyiF/mJS45qDDypPpob+5OIogoHgXXWI3lJwxEPUuH62bLkzu1xH4ACObJl5YiuR/6ehMfRTLB5s4TzqudKVRWz3awT5Sj6folMK0r+zdP/JKQt6ITEGf5dO4eDTOTw7cOIif1sGc3bKnDj4KBhIz483S7H5yKgaorbZAtdfwoX29vxzrOCNr1BBxPUus4Gvyi50Viu/avrHVCPJostfWY8fHokA6i6TZ38LAaKBeupZxaDQOf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixRMS1d82hbBKPn8wCLKDfizqvxiFmMGfWx1FYWcbzI=;
 b=WZgxs52NQtEVdmKbHBbvHSgHmdC1ccs+RU2g6owNxlj44VH87deg60ZZ4mQgKvIb7+DwSgH6jA7EftqqdWnds5WjxFq3LbivijZRvkwAO4ilg5uPOwsUf0wk2e9T8P4kH3cZysaPmUaRp0bv3LTKGgIpm0065DbZUT6RO5VKUdE=
Received: from BYAPR21MB1352.namprd21.prod.outlook.com (20.179.60.214) by
 BYAPR21MB1208.namprd21.prod.outlook.com (20.179.57.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.6; Fri, 21 Jun 2019 23:58:27 +0000
Received: from BYAPR21MB1352.namprd21.prod.outlook.com
 ([fe80::b52f:faf3:6bc6:32de]) by BYAPR21MB1352.namprd21.prod.outlook.com
 ([fe80::b52f:faf3:6bc6:32de%5]) with mapi id 15.20.2032.005; Fri, 21 Jun 2019
 23:58:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
CC:     "Lili Deng (Wicresoft North America Ltd)" <v-lide@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Subject: RE: [PATCH v2] PCI: hv: Fix a use-after-free bug in
 hv_eject_device_work()
Thread-Topic: [PATCH v2] PCI: hv: Fix a use-after-free bug in
 hv_eject_device_work()
Thread-Index: AdUoio+jbgfPCntMRSGnwgYrj5f2wwAAnXww
Date:   Fri, 21 Jun 2019 23:58:26 +0000
Message-ID: <BYAPR21MB1352C5D60C33D9AAD204554FD7E70@BYAPR21MB1352.namprd21.prod.outlook.com>
References: <PU1P153MB0169D420EAB61757DF4B337FBFE70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169D420EAB61757DF4B337FBFE70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
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
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ebb80ce-97d0-455c-c7e2-08d6f6a45a53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR21MB1208;
x-ms-traffictypediagnostic: BYAPR21MB1208:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1208B0DE7E93D98FCC908AF6D7E70@BYAPR21MB1208.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(396003)(376002)(39860400002)(189003)(199004)(8936002)(6436002)(53936002)(74316002)(4326008)(229853002)(6506007)(14454004)(55016002)(22452003)(478600001)(71190400001)(186003)(7736002)(71200400001)(81166006)(33656002)(8676002)(110136005)(2201001)(316002)(5660300002)(81156014)(54906003)(9686003)(7696005)(68736007)(8990500004)(86362001)(10290500003)(10090500001)(99286004)(76176011)(64756008)(476003)(66476007)(25786009)(6246003)(66946007)(486006)(26005)(102836004)(6116002)(76116006)(305945005)(11346002)(2906002)(66446008)(3846002)(73956011)(66556008)(1511001)(14444005)(2501003)(446003)(256004)(7416002)(52536014)(66066001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1208;H:BYAPR21MB1352.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FQmnkOIYPTE1kj3T23KQoq8en1tYA1HPuWcshfzf1yOrXuFZuXSiNmLSeTUUesl2FhkPTKKn6GZifwYbSPmgWK05n5vaQigJgInih1lEv66DjyvQ/357PFRrvbCSWX8g5ODPibhb745c0SgYtEvttUGzJqb2SBaSnXTDtGNCYcVci+Ugc2Kr5DlzeC0cTCvbv4afgUfF0m8Cp3WHioh22lQ6vijrTfI9H48Y9swm9X9cZS7f3geFXMIUTkG7zvkBVJDno6trZJ0veheeXaQCgd8tGmlCoB9h/EK9pdJEjC26hPyLLCk1wGu3WiVl5GGAN1CoT9RMHhJ3g9y2gV/Ir1QTgtCWRvU25smR37cHVOjJDdXACE2I93CZX4tZvecagD05XwCh9W0qs4/35mBiUZumZ/vvdESQkwROfh+GmQo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebb80ce-97d0-455c-c7e2-08d6f6a45a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 23:58:26.8892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1208
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Friday, June 21, 2019 4:45 PM
>=20
> The commit 05f151a73ec2 itself is correct, but it exposes this
> use-after-free bug, which is caught by some memory debug options.
>=20
> Add a Fixes tag to indicate the dependency.
>=20
> Fixes: 05f151a73ec2 ("PCI: hv: Fix a memory leak in hv_eject_device_work(=
)")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
>=20
> In v2:
> Replaced "hpdev->hbus" with "hbus", since we have the new "hbus" variable=
. [Michael
> Kelley]
>=20
>  drivers/pci/controller/pci-hyperv.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 808a182830e5..5dadc964ad3b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1880,6 +1880,7 @@ static void hv_pci_devices_present(struct hv_pcibus=
_device
> *hbus,
>  static void hv_eject_device_work(struct work_struct *work)
>  {
>  	struct pci_eject_response *ejct_pkt;
> +	struct hv_pcibus_device *hbus;
>  	struct hv_pci_dev *hpdev;
>  	struct pci_dev *pdev;
>  	unsigned long flags;
> @@ -1890,6 +1891,7 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	} ctxt;
>=20
>  	hpdev =3D container_of(work, struct hv_pci_dev, wrk);
> +	hbus =3D hpdev->hbus;
>=20
>  	WARN_ON(hpdev->state !=3D hv_pcichild_ejecting);
>=20
> @@ -1900,8 +1902,7 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	 * because hbus->pci_bus may not exist yet.
>  	 */
>  	wslot =3D wslot_to_devfn(hpdev->desc.win_slot.slot);
> -	pdev =3D pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain, 0,
> -					   wslot);
> +	pdev =3D pci_get_domain_bus_and_slot(hbus->sysdata.domain, 0, wslot);
>  	if (pdev) {
>  		pci_lock_rescan_remove();
>  		pci_stop_and_remove_bus_device(pdev);
> @@ -1909,9 +1910,9 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  		pci_unlock_rescan_remove();
>  	}
>=20
> -	spin_lock_irqsave(&hpdev->hbus->device_list_lock, flags);
> +	spin_lock_irqsave(&hbus->device_list_lock, flags);
>  	list_del(&hpdev->list_entry);
> -	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
> +	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>=20
>  	if (hpdev->pci_slot)
>  		pci_destroy_slot(hpdev->pci_slot);
> @@ -1920,7 +1921,7 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	ejct_pkt =3D (struct pci_eject_response *)&ctxt.pkt.message;
>  	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
>  	ejct_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
> -	vmbus_sendpacket(hpdev->hbus->hdev->channel, ejct_pkt,
> +	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
>  			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
>  			 VM_PKT_DATA_INBAND, 0);
>=20
> @@ -1929,7 +1930,9 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	/* For the two refs got in new_pcichild_device() */
>  	put_pcichild(hpdev);
>  	put_pcichild(hpdev);
> -	put_hvpcibus(hpdev->hbus);
> +	/* hpdev has been freed. Do not use it any more. */
> +
> +	put_hvpcibus(hbus);
>  }
>=20
>  /**
> --
> 2.17.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

