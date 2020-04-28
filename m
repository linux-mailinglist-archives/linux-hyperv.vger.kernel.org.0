Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710F61BB6F1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2020 08:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1GmC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Apr 2020 02:42:02 -0400
Received: from mail-eopbgr1310109.outbound.protection.outlook.com ([40.107.131.109]:45312
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbgD1GmB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Apr 2020 02:42:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mho+J/2GbEAkYSVbTtga/TDqXn3u4O2B+MDknW/57r9PGJ5UKXkcT0ypCEDidYWs42/swEFTbmcE0YPisC13sgB1txDphZvMeVoUh8NSn54kyXRnVwIHtXFAwONYPhycLiH0buTEK0CuLgQk/RUiJgSaZwd7C5f0JYZ1g01ZwmHWH7I5Ifo956XW3OZfNO0XLLfH0fg/JbL0sC97ZKKTWY1izNifk9V9vcPkO3aiL+w7TRhKidYe/B6TQga2ijjVLD8Y3xwhavp3fScFY78aRJNfhOGongP2MsOpyoWhDhfKjTf8E+qjnvK9J1luA+ug39XTKDPFZ3xD+XqYX+kZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXEsiN/1i221B5WPRma0kAt6IS6p/N2kLMEaJZMGZBo=;
 b=g0gYawQ1OeN6gZdUvax9rHSJpGNYcRPPc1YY4HITC/x17mztMWTx0kE7eaWTQfuZINMGDfoiULd0GH/JGICuOSR6YzWgJDig5kcwYKrEmPG+Tbdg8/kW5bcfx5By7dkdWCcunobhJIpbuAWO0x8OG3w60Xpz/8whbo9fWHOk6qUkej9rIiwfuqmODvjx4ORgcj9vs+6LUx2vZ5a1tW8s58zTIEznzKc41RbhYYWeA4dg6NstnnT3z1npyXpNMbeAo3FXzvmTMpZ073kZgew4/K2dyG1dmUdNbHbbn0Mdq5IoudGuBcAX3GO0t797A4SaBlWr7jRQpyqDPyZUiQwi4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXEsiN/1i221B5WPRma0kAt6IS6p/N2kLMEaJZMGZBo=;
 b=g+70kuytT/Jgyaw5Q6X+y8/JED8VNc0d3OlFt+wy1I/O1rFEVWxFs2hNb6Zfamp/5yCBDzRcF1I1dTPzmR7Vn1KvWoWKHkWVPCoZrYxQNf4ysCeXNNrVm472L+QRpK3Vz7WEY8rvS6VtFO8aJXwtwDewvKsLEtvwYfiwPUJQJ/4=
Received: from SG2P153MB0213.APCP153.PROD.OUTLOOK.COM (2603:1096:4:8c::10) by
 SG2P153MB0302.APCP153.PROD.OUTLOOK.COM (2603:1096:4:d1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.3; Tue, 28 Apr 2020 06:41:55 +0000
Received: from SG2P153MB0213.APCP153.PROD.OUTLOOK.COM
 ([fe80::48c2:d836:48b2:689a]) by SG2P153MB0213.APCP153.PROD.OUTLOOK.COM
 ([fe80::48c2:d836:48b2:689a%6]) with mapi id 15.20.2979.005; Tue, 28 Apr 2020
 06:41:55 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Topic: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Index: AQHWG84ovaN1uUvkhEyVQA4OZviFu6iMGmYAgABt3HCAAJNSgIAA+23Q
Date:   Tue, 28 Apr 2020 06:41:54 +0000
Message-ID: <SG2P153MB0213A7F57F401678A744084EBBAC0@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
References: <20200426132430.1756-1-weh@microsoft.com>
 <MW2PR2101MB10523247FBE97CDA56E7F5A8D7AF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <SG2P153MB0213FD4A0061C892B38D995ABBAF0@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
 <MW2PR2101MB105241B940784CF73A8A9BB0D7AF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB105241B940784CF73A8A9BB0D7AF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-27T00:15:48.8414318Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3bb357e5-0b89-436f-ac44-3d0a980ed24f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [180.157.10.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56340c8c-8ea6-4380-c8ce-08d7eb3f3df8
x-ms-traffictypediagnostic: SG2P153MB0302:|SG2P153MB0302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2P153MB030278EB6E0A6B0B513999C0BBAC0@SG2P153MB0302.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0387D64A71
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2a9TnHXZpdZRYi7l+aLERqs0zzlPjDCiZENWChcdRLPyXuEFyrl9xji1RAzPGLVDQfgh7UrQF2PFHeeuG9hTfLb3bGXHupUHAuiLeu9K1HxDtoKq5zoWYqyNUTezrWWBy9/bf5mJ6ONONZDL8T2sFpuU2vvcTkYv4L6I2HM+OPvaGPGdIEl+VuhYsgwhzx3+Ugu7tk6T2BZ7m8+vSK2Ja3MZLI094AM6lEbWb3J5s/qla2TrDA/E/rHQlaOeQDkRl3g+YSwcixvUiMCdpQ8Dk6aIspjaT37m+3kaRDH7LAAjdiMl1uYsyFwMxlFjQju9Jf3SlR2ByJVoWCbF70zFHUd0Eomq7u6aKFi7iZB9OxjYkn7B/jsJdcqJPKM0TTt6hPxySj56D1I87N9twHto8AjxkAUYBmWa0cjAH7yJ+oBVHYtBhGvWCM9Okv/YHW4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0213.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(86362001)(9686003)(26005)(10290500003)(478600001)(6506007)(186003)(33656002)(2906002)(5660300002)(82950400001)(55016002)(76116006)(66946007)(82960400001)(7696005)(6636002)(316002)(66446008)(52536014)(8990500004)(64756008)(8676002)(66476007)(66556008)(71200400001)(8936002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tNI56PkcvT7LLwH7yailCTOROq11hv/KMmkuRPeM+GAd27HS7go9fPs1+qh49+TdR8AVTq71K3BFI1R+9hEPGi+SnOYJyTyuHO136HgJZMQ5oaWVbOVbqboMXoGUISREUmx0NRZcVRidWSZ5TAwYg+3vWiVHukOGKROGalgue2MohzggFvMutgjOoxOI7UKhQXu1Q1KYb5c+gpB28n5WIAZzdhK3tP5bqksD+v9/ApPGlmJ+PfnHAg25XZQMVNGuf3IYVYSYXmf206ov+3NztNQC/xIdIDC37akUHYTnX3thqfFLxHUJJAZmh8duC67DNnOuCa6r/3jCDBk4p/UvcpSVXbZ7E+LlI4gb8vipBOj0nFLKVTY9Rkt+bMN6M9K1dS3cTCoZvb8coiFWjAudpqHvScQYDyZRfCDoLi4PjQm9q0R5JAMn7hnuzYuEpCidDjyuzs96YjeWCYUaPgIrpsFtc1DKhAvnEPc8hwxV6cEm435NQF26iBQddgqPJxH9u/s2WPykfihws3lf5EK1bBhKhbw0/h+EzINE6hPF42dkEDSJ9p3+uZ8s61xBrw16jHSUz9DwVhnZYbq0bmTJY0LtJ4RptdnebSsMjSHylkV8xOjFZul2DjIfhtmc5c19vt6RAlOze2UErrgegcHiGdmZmEcuPpMG4LJmSYJ/pN6vjUi0DX7RCuhDHcG3vSpZDA8PD8tUtq5Yrt1uuD5PhXciDCwONfXg+754rmEQm86wq9wWq4rt8aVR6RoWZTOREkKUM0a4aU2j9Rte7raRpCJLTMAINUO7P/V6CQ+CQVI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56340c8c-8ea6-4380-c8ce-08d7eb3f3df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 06:41:54.6468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DE0yGyUwqoBLCCCDKxFEfvO+gKlfiqNyQqEaJyCUdsw4qbncbEApOJmHkxtin5zLYlihtZ68UZvP7PFAIcplw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0302
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> > > The above is good.  But there's another error case that isn't
> > > handled correctly.  If create_root_hv_pci_bus() fails,
> > > hv_send_resources_released() should be called.
> > >
> > > Fixing these two error cases should probably go in a separate patch:
> > > One patch for the retry problem in kdump, and a separate patch for
> > > these error cases.
> >
> > [Wei Hu]
> > hv_send_resources_released() is called in the added hv_pci_bus_exit().
> > If hv_send_resources_allocated() fails, is it correct to call
> hv_send_resources_released()?
> > Allocation can fail in the middle. So I am not sure if calling
> > hv_send_resources_released() won't cause any side effect.
> >
>=20
> Ah yes, you are right.  But that brings up a separate problem.
> If hv_pci_allocate_bridge_windows() or hv_send_resources_allocated() fail=
s,
> then the error path will call hv_pci_bus_exit(), which will call
> hv_send_resources_released(), even if hv_send_resources_allocated() was
> never called or didn't fully succeed.  As you noted,
> hv_send_resources_allocated() does multiple steps, some of which might ha=
ve
> succeeded, and some of which didn't.  The mismatch might cause problems.
> That means fixing this error handling is going to be a bit more complex. =
 Each
> operation needs
> to be individually undone, and only if it previously succeeded.   Could y=
ou
> follow up
> with the Hyper-V people to see if there's a problem with doing the
> RESOURCES_RELEASED message on a slot where RESOURCES_ASSIGNED was
> not done or wasn't successful?
> If doing a spurious RESOURCES_RELEASED is harmless, that will make the er=
ror
> cleanup easier.
>=20

I think we can clean this up by doing like following, without the need of c=
onsulting
Hyper-V team. The kdump retry also works with this by setting the wslot_res=
_allocated
to 255 before calling hv_pci_bus_exit() to retry. Let me know what you thin=
k.

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 0a42c228b231..06f31f5777f9 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -480,6 +480,9 @@ struct hv_pcibus_device {

        struct workqueue_struct *wq;

+       /* Highest slot of child device allocated resources allocated*/
+       int wslot_res_allocated;
+
        /* hypercall arg, must not cross page boundary */
        struct hv_retarget_device_interrupt retarget_msi_interrupt_params;

@@ -2873,7 +2876,7 @@ static int hv_send_resources_allocated(struct hv_devi=
ce *hdev)
        struct hv_pci_dev *hpdev;
        struct pci_packet *pkt;
        size_t size_res;
-       u32 wslot;
+       int wslot;
        int ret;

        size_res =3D (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
@@ -2926,6 +2929,8 @@ static int hv_send_resources_allocated(struct hv_devi=
ce *hdev)
                                comp_pkt.completion_status);
                        break;
                }
+
+               hbus->wslot_res_allocated =3D wslot;
        }

        kfree(pkt);
@@ -2944,10 +2949,10 @@ static int hv_send_resources_released(struct hv_dev=
ice *hdev)
        struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
        struct pci_child_message pkt;
        struct hv_pci_dev *hpdev;
-       u32 wslot;
+       int wslot;
        int ret;

-       for (wslot =3D 0; wslot < 256; wslot++) {
+       for (wslot =3D hbus->wslot_res_allocated; wslot >=3D 0; wslot--) {
                hpdev =3D get_pcichild_wslot(hbus, wslot);
                if (!hpdev)
                        continue;
@@ -2962,8 +2967,12 @@ static int hv_send_resources_released(struct hv_devi=
ce *hdev)
                                       VM_PKT_DATA_INBAND, 0);
                if (ret)
                        return ret;
+
+               hbus->wslot_res_allocated =3D wslot - 1;
        }

+       hbus->wslot_res_allocated =3D -1;
+
        return 0;
 }

@@ -3063,6 +3072,7 @@ static int hv_pci_probe(struct hv_device *hdev,
        if (!hbus)
                return -ENOMEM;
        hbus->state =3D hv_pcibus_init;
+       hbus->wslot_res_allocated =3D -1;

        /*
         * The PCI bus "domain" is what is called "segment" in ACPI and oth=
er
@@ -3162,7 +3172,7 @@ static int hv_pci_probe(struct hv_device *hdev,

        ret =3D hv_pci_allocate_bridge_windows(hbus);
        if (ret)
-               goto free_irq_domain;
+               goto exit_d0;

        ret =3D hv_send_resources_allocated(hdev);
        if (ret)
@@ -3180,6 +3190,8 @@ static int hv_pci_probe(struct hv_device *hdev,

 free_windows:
        hv_pci_free_bridge_windows(hbus);
+exit_d0:
+       (void) hv_pci_bus_exit(hdev, true);
 free_irq_domain:
        irq_domain_remove(hbus->irq_domain);
 free_fwnode:
