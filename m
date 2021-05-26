Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62A391FC1
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 May 2021 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhEZS4q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 May 2021 14:56:46 -0400
Received: from mail-dm6nam12on2111.outbound.protection.outlook.com ([40.107.243.111]:64959
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233217AbhEZS4p (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 May 2021 14:56:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmZr2riLDvkUsf0XeAXIvtvxiIz+ZluqRzuy+HXqxa5rjZPXP3gTkUzLkMULgWA/FsK9YFyV29hYUXoYFjqtUIbD4ByditXZ9abYEB2gdv0X3ONLbIsVw8h5mOaMJCYLpkS7y67C+vH1WKzdZ/z2Xxi7wETn/695FWie2O0wA+dhVwxNaztplvhWfsqiEDQz+FA9oZkKBBF6LfYO1Bu9LwErPPiihU6tgdsyOD4hjMJ085PsUim1u7vXKcX0+LNkfVDb33GzA33xECCjLxrEz7SpTV6NFZbX057BIUf5SEgyf3fxJi1VlkXhdy3ZpxDT3k430xfOt+Do9hoIVDLTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRQImDABUkvQbqc7lCskaYsGuK2RIj8hYo6UCr7vpB8=;
 b=BAFUnCpLfQoxltT58sCtNlY+l30it5j1WmQgYRcBD8TWANbG4azTKLkfx2gXTWLM/NFzlrhWm5JwZPmCtcwkF3KnK8Uy8Oux6r/XDCpxjb0Im/tuvfS/Y1uyWEF9hNTymoF0grDEJavgbZEH2MKVr/ElXHNYTIXq6rhIS29hNsBm365Mtwz8gcwr7+1XyJuqsT/D8LphH0BW/z9SXfABYoaWi9UoQk/geYIC5VTJ8S/AOg0ZClAlQXb/bZXi7Y+Pr8Lk7zKtploZ46Js+iIC9mqnLR2l3dNgaj1gj/i5vLox5LsEo5UpWTozkkHukEO/HAsO8Y1yyxvErEF3e6DjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRQImDABUkvQbqc7lCskaYsGuK2RIj8hYo6UCr7vpB8=;
 b=f9LA1kLCUYCh9+s5rS5UMNib+y5GXflyPP6v3UYCzwad4lAxSS5oFrHog13O708pavmK+4x0BDOr+m496t10fEPfTsy0WnCKh1IHCCJzzTIwkcmfl2kl2EC82yHNmfpkyMdn4yNxKeJd6HIKFOAdA1KVZ4L1qrtvl5vEdjFHiQI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB2026.namprd21.prod.outlook.com (2603:10b6:303:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.3; Wed, 26 May
 2021 18:55:12 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dc3:55b4:b9b3:11a8]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dc3:55b4:b9b3:11a8%4]) with mapi id 15.20.4173.023; Wed, 26 May 2021
 18:55:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [Patch v3 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Topic: [Patch v3 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Index: AQHXRwXCAOWbaKWUoUimheom/J0X76r2Msmg
Date:   Wed, 26 May 2021 18:55:12 +0000
Message-ID: <MWHPR21MB1593018C491CE32A7F54ED0ED7249@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1620806800-30983-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1620806800-30983-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cad1486d-2d96-4193-8761-ca18e7633cdf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-26T18:53:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxonhyperv.com; dkim=none (message not signed)
 header.d=none;linuxonhyperv.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b81e2a3-be1b-4438-67bd-08d92077cac6
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB2026310EB267E19CCE57A004D7249@MW4PR21MB2026.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2A1PCsdT5d7xaXJgKF5u8GnfAK+ZX1a0dM7a/FaN3f5nw8rgqx+J95samiYEHqAJB8R1E5LfAcKwrX0fX4XGt1z78Gi9Ro+ncKeY6uj3fIz7QS5CjtspgrhFIKL//k6VLbW8zx60pKdTCQIgEyJtXSLumCkCk3WrbJ8QaXq16EMjlNT7/qNaAnX7I+e6fc5FULklePLAnzBjwZm9bt9uNnNv27NS+Fk18/AT4I057+LmftHIsbXG2MvL2nV1e77c4pI0+kkYbOLjOLEeMuOvD5q+7Ly1Oc94hiZzwP4y8oy3AXSz77TKGf2A8OwDc52gduinD7jIIBwqEADTJGOT2v/znan5ehiJR1eenWZwlH58ruxDrFb1jqXHuUHABprYgmMuMHjhLTS0szFRlV8OyLuilp13NAzTDFupMFf8uP+nCJ7NF1WnDk5E2kQ3LDyjV39A1GafbZ3VNKMc3H+BnXpOimVxWdhXw5GlFUrBv3IRR4b5MJB2Ou/uGDfn0Xt/zqK+lbHrVaRwOyQ4bBxH7x/zAYZAeNLcsmPp8GE6iSH2KoLbi5euQ4HrBOmfXama3kUJcKGVjb0UL9sTzGZyqqg3TOIORcSRt7CE8O6h2PzOHPumDI4tnMlaIbrdfhv2fePBZfHKEkGFWGffGn/DNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(10290500003)(82950400001)(82960400001)(66476007)(66946007)(66556008)(316002)(107886003)(921005)(7696005)(64756008)(55016002)(66446008)(4326008)(71200400001)(52536014)(478600001)(8990500004)(8676002)(38100700002)(122000001)(8936002)(5660300002)(33656002)(26005)(110136005)(2906002)(6506007)(9686003)(83380400001)(86362001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jTYl+s90lzZYBPBhEajpNdHa7fd/lKhX+M+zu4ns+zf/b6VOC6jLNIzUhY0h?=
 =?us-ascii?Q?DoCxlS31iVn+t/8AUZHUBv6mg2Z+KixGXbZPaTTJ1RehLAwUDsaaaF8Rf2kH?=
 =?us-ascii?Q?hT+fhlUYTwdJMXRZ1Hurmxk+BJpsPMI6KWu49i4emM/kl3f3AAaFFia7/Lh4?=
 =?us-ascii?Q?tI0OhbN6hakS5f+gI5tEDapbhbm5ms/28E8OfASoiUIoai3fT7C2+eanBXC3?=
 =?us-ascii?Q?xaEvqFNYPkKhzXemmWdSjYcCVt7jw0AcULADlz7TH4cHJdcFG3K9sSdSeOGs?=
 =?us-ascii?Q?QONk5n5iHd3kj71AADi34cKAF/8FnCKg080RetoGvGZxc3cCLchdafVsWbAf?=
 =?us-ascii?Q?jl5NkxhnKoxSvbBYHfDRvG0wLNDQEZZXvkD2IdPxr+iP9jpbsoxngX/32hCC?=
 =?us-ascii?Q?bfugS5CKOp/hBbN3AQYpqBth8nGm57v5lLN5pTBdoIMrhs5ikMtRUrIf3/fN?=
 =?us-ascii?Q?WJaSzPUI752EbsSWVqgKw5FfMjDL74Rn229eywYlAuASUQKBISuFv3TMjeUw?=
 =?us-ascii?Q?1SawJEBhNKybVW8FBMsB1N8gbXWsadvuwwcr7uGtsf3o8g8zlUFn+Roe+I4y?=
 =?us-ascii?Q?7wp6uZNtymzvnqFkuewsd5r+ScXldpD4ZQEy+AU/9ZdQzQtwrJJtuxOjkE/1?=
 =?us-ascii?Q?djhAqTSGwdKfbMcDcJ1W9XDHFQs4wSMag0raDbg0GjFggEwnw9fqXlBc8Y+2?=
 =?us-ascii?Q?1SV8TdbFu1aJXwueZactGRbbNiQwvtvfb+CtWx71HW011NyUEJWuJodnNjB4?=
 =?us-ascii?Q?5OAkDQN90kMNVJcjrGIZ8omFbj4S5x81ZBcMWPAqncEviZR/DpIbNaDFGami?=
 =?us-ascii?Q?zxhZfXnFK6RmpEpZWnE5BXZ64hxbu+uzvnuRc1n8chC3YnlVI2bAQc74rt78?=
 =?us-ascii?Q?EMKi1oOemwS3f4A4BlSQzb05oDvUi/iXY/PWPsdzcfUEl4VrWImxeXSxjcxq?=
 =?us-ascii?Q?4mTpEw67pWWjsPX7FLMt7d2rOadtW9+jL/5qxM8r?=
x-ms-exchange-antispam-messagedata-1: Is2mPWIzjMouWf2AHx0OSH7AfzDMlfqO8skwq8DIZr9fzMHJHQuGGnQD3r1Yx7CVeIpxKDs1pN/Sdq5VcQCz15IZPKR8oFxY60Xe/Q00SFFWfk5dSv90VnbNTuWP/Q9+HPjwwxMK6v8uF3NNdYbPN2VIZgcz8OowwgXbMLTFNjiaytdSLpMdAGq02cpjx4NnOLJ3mcfHQCoceUrkhoNw/EEVgS942RvvksyyRI8WGM0grYn58MbsE8YE0mMbvmi1IyXJBlDdefQOeCnma/RAxqswcGGWlr49EO7qz0/k3QcVd8Stxfh0XYaPqE2sgbEUwFQLCEd93IxozsJA+lP7J5CC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b81e2a3-be1b-4438-67bd-08d92077cac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 18:55:12.2624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBhJjx/nttaJDS8iccSdIhai4zwmiEaZ1LQlzqaGVrOw639YirNyUFBD/Al2vQhXYwMuuhU4kN/Tg2TMe0NeN71PLnV4D0zzNon8mzda/pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2026
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Wednesday, =
May 12, 2021 1:07 AM
>=20
> On removing the device, any work item (hv_pci_devices_present() or
> hv_pci_eject_device()) scheduled on workqueue hbus->wq may still be runni=
ng
> and race with hv_pci_remove().
>=20
> This can happen because the host may send PCI_EJECT or PCI_BUS_RELATIONS(=
2)
> and decide to rescind the channel immediately after that.
>=20
> Fix this by flushing/destroying the workqueue of hbus before doing hbus r=
emove.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> Change in v2: Remove unused bus state hv_pcibus_removed
> Change in v3: Change hv_pci_bus_exit() to not use workqueue to remove PCI=
 devices
>=20
>  drivers/pci/controller/pci-hyperv.c | 30 ++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 27a17a1e4a7c..c6122a1b0c46 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -444,7 +444,6 @@ enum hv_pcibus_state {
>  	hv_pcibus_probed,
>  	hv_pcibus_installed,
>  	hv_pcibus_removing,
> -	hv_pcibus_removed,
>  	hv_pcibus_maximum
>  };
>=20
> @@ -3247,8 +3246,9 @@ static int hv_pci_bus_exit(struct hv_device *hdev, =
bool
> keep_devs)
>  		struct pci_packet teardown_packet;
>  		u8 buffer[sizeof(struct pci_message)];
>  	} pkt;
> -	struct hv_dr_state *dr;
>  	struct hv_pci_compl comp_pkt;
> +	struct hv_pci_dev *hpdev, *tmp;
> +	unsigned long flags;
>  	int ret;
>=20
>  	/*
> @@ -3260,9 +3260,16 @@ static int hv_pci_bus_exit(struct hv_device *hdev,=
 bool
> keep_devs)
>=20
>  	if (!keep_devs) {
>  		/* Delete any children which might still exist. */
> -		dr =3D kzalloc(sizeof(*dr), GFP_KERNEL);
> -		if (dr && hv_pci_start_relations_work(hbus, dr))
> -			kfree(dr);
> +		spin_lock_irqsave(&hbus->device_list_lock, flags);
> +		list_for_each_entry_safe(hpdev, tmp, &hbus->children, list_entry) {
> +			list_del(&hpdev->list_entry);
> +			if (hpdev->pci_slot)
> +				pci_destroy_slot(hpdev->pci_slot);
> +			/* For the two refs got in new_pcichild_device() */
> +			put_pcichild(hpdev);
> +			put_pcichild(hpdev);
> +		}
> +		spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  	}
>=20
>  	ret =3D hv_send_resources_released(hdev);
> @@ -3305,13 +3312,23 @@ static int hv_pci_remove(struct hv_device *hdev)
>=20
>  	hbus =3D hv_get_drvdata(hdev);
>  	if (hbus->state =3D=3D hv_pcibus_installed) {
> +		tasklet_disable(&hdev->channel->callback_event);
> +		hbus->state =3D hv_pcibus_removing;
> +		tasklet_enable(&hdev->channel->callback_event);
> +		destroy_workqueue(hbus->wq);
> +		hbus->wq =3D NULL;
> +		/*
> +		 * At this point, no work is running or can be scheduled
> +		 * on hbus-wq. We can't race with hv_pci_devices_present()
> +		 * or hv_pci_eject_device(), it's safe to proceed.
> +		 */
> +
>  		/* Remove the bus from PCI's point of view. */
>  		pci_lock_rescan_remove();
>  		pci_stop_root_bus(hbus->pci_bus);
>  		hv_pci_remove_slots(hbus);
>  		pci_remove_root_bus(hbus->pci_bus);
>  		pci_unlock_rescan_remove();
> -		hbus->state =3D hv_pcibus_removed;
>  	}
>=20
>  	ret =3D hv_pci_bus_exit(hdev, false);
> @@ -3326,7 +3343,6 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	irq_domain_free_fwnode(hbus->sysdata.fwnode);
>  	put_hvpcibus(hbus);
>  	wait_for_completion(&hbus->remove_event);
> -	destroy_workqueue(hbus->wq);
>=20
>  	hv_put_dom_num(hbus->sysdata.domain);
>=20
> --
> 2.27.0

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

