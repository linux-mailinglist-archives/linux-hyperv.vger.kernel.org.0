Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2971BECB6
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2020 01:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgD2Xra (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Apr 2020 19:47:30 -0400
Received: from mail-dm6nam11on2133.outbound.protection.outlook.com ([40.107.223.133]:63307
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbgD2Xr3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Apr 2020 19:47:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFNcQ8Z3Rp0dxnxeJR4xM7EHCv6euvZ8Mf4KW3pwAsxkBEpTS3fxkKjjS9AcFVFmrzygEDXIbfqtlErb/7We3/KervWHLaeL7ZmNEj9tERVXYP1swygkO77a7pNyjxuKZYyIoGJiTpLj3EcGjKiDC1Y/f57GOhE5QNfNX4vbZEdOpL/OK9Yqkm3wa3NhHh+A5rjjI/yNkAsVY6Z4lKOPSWkfO1LGLC0pOWFHlso8ol4vWPKOKiBKfQiQKU4ecqlhnRvNTLGUqWXgJqY8HR+xZ0XF5mieFDafjm8EHbDJAdllzZ2e7XMpGiMIIqQ+tGOomodbQDjGnq2URAQ4JmkM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzEmHlIyVK6FPs2PjSHrU4n+2AWJCw7JFNdOht7Mx+I=;
 b=Jand0vE3yKmxLGzcZn/2FKZ3cHRZjAxlLRqDnl+eEbRIZONX9PAju4d0FMfH6q3HCMK95c0FBgEpkgQK/hk1Z0SXPCXBWVak3+QghQPJbdiiw1WUQ+l0Ol2AvR2zNQdSTEslU6rCKxtrbirc17mS01/LtkyN++FhIjJlsuYCYqi61C8eRCOdg7rq9rXfrMiukwqfW71IqyvyjZFiKb8KFA7Sco/Au/ZlMA5qj5ibeK3FXYd2z8qZQVdm2yN0kUZaMU8wCGUk/8nJFC6eYT2hxNEYcJHQLpM8alhzAdpdY151Ttj56TSYY/kz4nEbs1Z4GXobVG9dH3n83mUbkHuGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzEmHlIyVK6FPs2PjSHrU4n+2AWJCw7JFNdOht7Mx+I=;
 b=VTSJz9NLXX4Mx92FEGGvCtDZefRxG0X1IS/fePs125pTrLbPpdOwSEb6GhfIQPFU0eT4JN1vWM0Ar+H4cBZcChfdg7mfHYX5ONl7dsteJ0kaSy2PBzHzJtmGmdEhFwwzspfWA6pcibDM9ba109B0dck7vVDIeLiVwC4q+iWvkH0=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1020.namprd21.prod.outlook.com (2603:10b6:302:9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.3; Wed, 29 Apr
 2020 23:47:25 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950%5]) with mapi id 15.20.2979.013; Wed, 29 Apr 2020
 23:47:25 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Topic: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Index: AQHWG84m7LFBk05zpkqgxdg/cn42SqiMEvJQgAB6BACAAIuS4IABABEAgAKuCiA=
Date:   Wed, 29 Apr 2020 23:47:24 +0000
Message-ID: <MW2PR2101MB10527ACF47250956BA0EAB4ED7AD0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200426132430.1756-1-weh@microsoft.com>
 <MW2PR2101MB10523247FBE97CDA56E7F5A8D7AF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <SG2P153MB0213FD4A0061C892B38D995ABBAF0@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
 <MW2PR2101MB105241B940784CF73A8A9BB0D7AF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <SG2P153MB0213A7F57F401678A744084EBBAC0@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB0213A7F57F401678A744084EBBAC0@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
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
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fd41241-7ba3-4006-0847-08d7ec97ab0f
x-ms-traffictypediagnostic: MW2PR2101MB1020:|MW2PR2101MB1020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1020DCA9BB63773AD7F73F6DD7AD0@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03883BD916
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H2jzaGY28E9xK9Znmf3HLQ5IYNldb0UM610zhErbPXf0PzQKB81FhxQxU18qxT+pISPbc5U1HRLoktoA1f5m9qXTz6Md0tY5925xQVRZhsgkx0TSfnl51xi4pKHFwH7sxwJN2wpO9mLpsOvObIN2/tvvGHIwCE5Xj89diCfqNM7mxFF8y26moopxghNcntqIv2y6mwMecZ3Km9pVc0OJwwfHbVTSy1DwpNDOD2FKNvtsJgTobx2bSXIytgAeoYEUtL8owPFNm6YZ5jTK94E2rWChcgDtUpXYe92E86zuU+meA3PY+YQRqqU/Zld57Mymle2cdR66uypbcQxmpCkLl3rvx6PbNvgC8pqIK93weIDFwc1435sPqUzJftp0nuZ1foqd8Cq3BGzFiGQJY24alqHt+EkEkMnL+nqEuUjH+XEA+qiTsd3yQohR0UA2PJNk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(110136005)(316002)(71200400001)(6636002)(33656002)(478600001)(9686003)(8990500004)(86362001)(55016002)(10290500003)(82950400001)(5660300002)(66476007)(82960400001)(66556008)(66446008)(8936002)(186003)(64756008)(66946007)(52536014)(8676002)(2906002)(26005)(6506007)(76116006)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6vkY7LICak10Jt0X8eIt2wnT5uMN9OSj/OC414jgi22DYrThf6O3TIRfPIaArOn3Y+a2xzo5l8rWSzlLJ4qIXtDBqu9dygxg3Ri/AMYzaIK9K3FIhNXxMMZHgjAZ/gkmdalVwkgf0JlZgyEHFcQYURdIvD8ICFcbBsG9fQvoyqoPYt8Jk/PsPRFHIjtahzEat0U5FfbgQx7D9wIgm66l2aKpUP5hO5nAS/ozDxD4jUTxtrImxE8r2xZ3dA1W9ktcbKEJUKIAg0hK+ObwM4Fa7cIgeh0A1Wz5NCO1BwTuyL5Tkd3LGGA4FxMx+dZiSGSDTg3zV9UbjPAUivsLr+U5RnlEFRR3kiDasQVvaUOB+tJCzbOIzTdpeYxRr27Hkqg0McipKU3VclX4alR2uG6f1+imhv70YdiKlKf28bVV8ToZLtF9WrIvX1pMsjjR/q1ZRVnKezFOcSZn18EJER02dwFEo9PLhFu30PGnBDSFhiykZrd5joFHOOv6FJey/QgNQVS2FaqLYw6d/QQwC6W+C52Bxof1G9qMtBBz7Bcv/hEkzog750y39LXtiYOq0GjUNpGG7W6YB0TnDwzMqJdtRwB7Dckedk2q64pdz7QnIfGqNvfTcTPIKvx1dSVJGZNxijb9vS1rCorwoqfa4qeHmxigwNe6Vajh9+hhuhSPyVDSNfenxMjPyxnu+CLzYghzzDskPgaNu3gyTy5j4q0MlCKeCsPh32x4BjVk1+ERvQO0HSuIdsi3k/cTom17i5zntwPbVgdJ79KPwdtBE547k0cDCs6e4sIC21BotCy42Fs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd41241-7ba3-4006-0847-08d7ec97ab0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 23:47:24.9041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAwgE6tLPYiJtWx9P1c8nw+NVm33XrCk+MIg9vrV2z8QbiFq9RfJBbM2Ve8CZp02eFvbzGvWvYlIv9QJFUC/E11U5u/lkg7HT45QxIbeaGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com>  Sent: Monday, April 27, 2020 11:42 PM
> > From: Michael Kelley <mikelley@microsoft.com>
> > > > The above is good.  But there's another error case that isn't
> > > > handled correctly.  If create_root_hv_pci_bus() fails,
> > > > hv_send_resources_released() should be called.
> > > >
> > > > Fixing these two error cases should probably go in a separate patch=
:
> > > > One patch for the retry problem in kdump, and a separate patch for
> > > > these error cases.
> > >
> > > [Wei Hu]
> > > hv_send_resources_released() is called in the added hv_pci_bus_exit()=
.
> > > If hv_send_resources_allocated() fails, is it correct to call
> > hv_send_resources_released()?
> > > Allocation can fail in the middle. So I am not sure if calling
> > > hv_send_resources_released() won't cause any side effect.
> > >
> >
> > Ah yes, you are right.  But that brings up a separate problem.
> > If hv_pci_allocate_bridge_windows() or hv_send_resources_allocated() fa=
ils,
> > then the error path will call hv_pci_bus_exit(), which will call
> > hv_send_resources_released(), even if hv_send_resources_allocated() was
> > never called or didn't fully succeed.  As you noted,
> > hv_send_resources_allocated() does multiple steps, some of which might =
have
> > succeeded, and some of which didn't.  The mismatch might cause problems=
.
> > That means fixing this error handling is going to be a bit more complex=
.  Each
> > operation needs
> > to be individually undone, and only if it previously succeeded.   Could=
 you
> > follow up
> > with the Hyper-V people to see if there's a problem with doing the
> > RESOURCES_RELEASED message on a slot where RESOURCES_ASSIGNED was
> > not done or wasn't successful?
> > If doing a spurious RESOURCES_RELEASED is harmless, that will make the =
error
> > cleanup easier.
> >
>=20
> I think we can clean this up by doing like following, without the need of=
 consulting
> Hyper-V team. The kdump retry also works with this by setting the wslot_r=
es_allocated
> to 255 before calling hv_pci_bus_exit() to retry. Let me know what you th=
ink.

I like the overall approach.  I've reviewed your code below, and I think it=
 works.
For the kdump situation, the assumption is that if we get the failure in en=
ter_d0(),
then the PCI device must have been successfully set up in the main kernel. =
 The
occupied slots found by the kdump kernel must the same as the occupied slot=
s
that were found (and setup) by the main kernel.  Therefore it is OK to iter=
ate
through all 256 slots in hv_send_resources_released() on the retry path.  M=
ake
sure to add a comment with that reasoning. :-)

Michael

>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 0a42c228b231..06f31f5777f9 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -480,6 +480,9 @@ struct hv_pcibus_device {
>=20
>         struct workqueue_struct *wq;
>=20
> +       /* Highest slot of child device allocated resources allocated*/
> +       int wslot_res_allocated;
> +
>         /* hypercall arg, must not cross page boundary */
>         struct hv_retarget_device_interrupt retarget_msi_interrupt_params=
;
>=20
> @@ -2873,7 +2876,7 @@ static int hv_send_resources_allocated(struct hv_de=
vice *hdev)
>         struct hv_pci_dev *hpdev;
>         struct pci_packet *pkt;
>         size_t size_res;
> -       u32 wslot;
> +       int wslot;
>         int ret;
>=20
>         size_res =3D (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
> @@ -2926,6 +2929,8 @@ static int hv_send_resources_allocated(struct hv_de=
vice *hdev)
>                                 comp_pkt.completion_status);
>                         break;
>                 }
> +
> +               hbus->wslot_res_allocated =3D wslot;
>         }
>=20
>         kfree(pkt);
> @@ -2944,10 +2949,10 @@ static int hv_send_resources_released(struct hv_d=
evice *hdev)
>         struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
>         struct pci_child_message pkt;
>         struct hv_pci_dev *hpdev;
> -       u32 wslot;
> +       int wslot;
>         int ret;
>=20
> -       for (wslot =3D 0; wslot < 256; wslot++) {
> +       for (wslot =3D hbus->wslot_res_allocated; wslot >=3D 0; wslot--) =
{
>                 hpdev =3D get_pcichild_wslot(hbus, wslot);
>                 if (!hpdev)
>                         continue;
> @@ -2962,8 +2967,12 @@ static int hv_send_resources_released(struct hv_de=
vice *hdev)
>                                        VM_PKT_DATA_INBAND, 0);
>                 if (ret)
>                         return ret;
> +
> +               hbus->wslot_res_allocated =3D wslot - 1;
>         }
>=20
> +       hbus->wslot_res_allocated =3D -1;
> +
>         return 0;
>  }
>=20
> @@ -3063,6 +3072,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>         if (!hbus)
>                 return -ENOMEM;
>         hbus->state =3D hv_pcibus_init;
> +       hbus->wslot_res_allocated =3D -1;
>=20
>         /*
>          * The PCI bus "domain" is what is called "segment" in ACPI and o=
ther
> @@ -3162,7 +3172,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>=20
>         ret =3D hv_pci_allocate_bridge_windows(hbus);
>         if (ret)
> -               goto free_irq_domain;
> +               goto exit_d0;
>=20
>         ret =3D hv_send_resources_allocated(hdev);
>         if (ret)
> @@ -3180,6 +3190,8 @@ static int hv_pci_probe(struct hv_device *hdev,
>=20
>  free_windows:
>         hv_pci_free_bridge_windows(hbus);
> +exit_d0:
> +       (void) hv_pci_bus_exit(hdev, true);
>  free_irq_domain:
>         irq_domain_remove(hbus->irq_domain);
>  free_fwnode:
