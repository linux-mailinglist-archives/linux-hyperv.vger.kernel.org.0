Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56972621C3
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Sep 2020 23:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgIHVQR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Sep 2020 17:16:17 -0400
Received: from mail-co1nam11on2092.outbound.protection.outlook.com ([40.107.220.92]:1888
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbgIHVQP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Sep 2020 17:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6QNtugjehCLTHeyYaZqGNA5I8QU+2S8STmObxuFtDMVU8nudMcfncime4VvYigkwoelIeuzsIPeHzUH64IJPAWeA+5z7zYrNePdjm5TFH9HKPMprZY6cKiv2ZqVzopYExxTLS+OY2hnSEnw8oZogJlLr5w2RmP68VG9++C64rjbs3gl3Zbs6kDtsA86PHwhsaucIczcDulLyDywLS758cA9celYjzvxWWtcOdz/Uz2iPocWR/V3hJYGGN393VmOuDlUHh5qmhQgWBHbPyddZjdl/AFiUSRnAyEM/PP/E5xFuG58RbsHqAmSeYTC+x6cr+lKi08NstKpvVNXgfBGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQATI4cmhC0onqvrW/Xy+h+jj50FAJ0/ZqPEW+2fuLU=;
 b=TlPVphIdz3L/EuKg3qHt2uj5YhOoPTzvuwOHLRtcMkmQSJKxAoZHoK0Ta/yoXTOm7Qw2vhFmNovbMKXdkyGHpwRRgwy+rupIT1qwkBDEctuHrLFyqSjpxJPU5SvwHHpTrvItBum8Vav9VgYRiItePT7AhjxD7UmXcXQmsTEawiMRTRyyVGdkh7WB8IlzCyc8p112k8aAWtNQkR6QsrdTDGL7lc6MNnNoCiEEwqRYWGkEJPSdVRz8cneZHhTEfxysAtV+RGS/3334E+lJEVs8C8TFcQNWXcfHoUjV/UC5xREj2peOAPXtQVf9HJ0YEueXcAn5A7giypQ4Q96rtI+sZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQATI4cmhC0onqvrW/Xy+h+jj50FAJ0/ZqPEW+2fuLU=;
 b=budQ1p10UmXR73M5Npp9Buu7YWSjXS58czbX87g5f3pdc2R6vqPc3JiHAiXr7yz5nP0cG/FsFavky0sxqtptI+tGtBcr4TU7Y0v/TcL2nGptpYGwTqOsq7c7U3TSwIPG8BVSsUbp9XlGwfWI3FmMyCcdM0viK+v2x28Q8IDxpyM=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1002.namprd21.prod.outlook.com (2603:10b6:302:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.3; Tue, 8 Sep
 2020 21:16:09 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1%5]) with mapi id 15.20.3391.004; Tue, 8 Sep 2020
 21:16:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jake Oshins <jakeo@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Topic: [PATCH] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Index: AQHWgzAAQgytpURzi0G46BH/yzzFMqlfQ83g
Date:   Tue, 8 Sep 2020 21:16:09 +0000
Message-ID: <MW2PR2101MB10525ED3B3B67E619861FB97D7290@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200905025450.45528-1-decui@microsoft.com>
In-Reply-To: <20200905025450.45528-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-08T21:16:08Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=04fdfc6d-c53a-476d-93bc-cf289a0243f3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 611dbfd3-aff7-42fe-73c9-08d8543c686c
x-ms-traffictypediagnostic: MW2PR2101MB1002:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1002894E8EEDF2B1AD684789D7290@MW2PR2101MB1002.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: izQeJ4K7X9BDifysnrjALiRLl3oswH1PK0x+6gtFgOFFZjX2pghIQXH4HPmGVYbfsVEXJo06e/1YhgWCGsixIQYrbMHJbsp0M1eGu0jbBlB759hwFZbwxjBhbfgxKxALFZDcrmve8iJbN+q5fCMI0jwaxWjIKvt/qdEox36dqxuEa3CDncEu4hJq6vQY1WjroPBR7evSSqSz+ncjZKgHh2bjzeJaMbkD8o14LDGA/0COkPrwgTX75uQL1a95LIijZt8Pbr4F5KOCM4nh4U2ltdi5h7zyzCwjbju6Vp39cB9dO7c3qGliMYunB/z3shj2ZyfdMrdf/1XNyBTH2ndXwsxPCdGIGPMH6EZoa/Rmlx1ap7bzfBlk0L3jJAhyFDQHOM7iEk5lnXRfosA6ktOsQWI++U8jk2wGOfOHsMgH6Og=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(107886003)(478600001)(10290500003)(82950400001)(82960400001)(7696005)(9686003)(8990500004)(2906002)(71200400001)(316002)(4326008)(5660300002)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(52536014)(110136005)(55016002)(33656002)(86362001)(8936002)(186003)(26005)(6506007)(83380400001)(8676002)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: txnXOYtFcFV+RIJJMZWPtErMBOCkdYtTgn2p+UjjAeKML6YXGAdC7e83uukTpxxVR4Zzr8AamMa/eJQdhA1Ebko0Do960fJXklNxnUf1CCqBF5c1j6lb9OQTZl0YpCBeEDSTJLNq7iKXhI2KkNbzeboVKaFkuVANbNN/ZVWLSPJsu4FX4TyJQFRAyZpp/H0+6hxO+EhEyev5zKSHkgWve6my2/PGQuqfgRlTnB2Tpz1lXp/jHQmtsWc/aYlY083NxT+fs9uMMm9d+wPYx21TjZNaeDigDnlUi8kqT5CneB+0CXSP3NzX3fU1qlZpjyGB6DTodyNGdJXM+/JCnWqI3Nuy5m0Sq79n83aux1Daby34YUI37PF0VfLsRJtyzWdkEOtfp3T0dwDCC2uzrZr6+klh6DJ2NcucOeGwzmcM+cQ8Obti9V91c83AEpziyZiugcUMMTOa+/j3dm93vTl4R6qLxXHXQrKn2yVF2FCd781zKRXQIOpkV4fxKlgKHBAjaj9YEd6Dn65Lh4NwHNnfv3MTQUS6qnOxfFC0Kw0mXTq7ffJbH8Q1lgrRBzJediOpBTMfD0M5Oq2L+xk7R264L+AAu6zKEkAA4EgVWXdG0pMKERFzBvaL/GuyQHjrcAl6c5cTu6Dbz6uar8L/4e32DQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611dbfd3-aff7-42fe-73c9-08d8543c686c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 21:16:09.8105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEM6cYq3yRMWIvr4qVcc7CMBAzqdea5Y6kIC82oLzmvbEVsEnhcl1fqnffpbMk1wubAC0Tc4i39jOi0H9QqyFTawZ/lszHQeSkEWULJKHoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1002
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Friday, September 4, 2020 7:55=
 PM
>=20
> Hyper-V doesn't trap and emulate the accesses to the MSI/MSI-X registers,
> and we must use hv_compose_msi_msg() to ask Hyper-V to create the IOMMU
> Interrupt Remapping Table Entries. This is not an issue for a lot of
> PCI device drivers (e.g. NVMe driver, Mellanox NIC drivers), which
> destroy and re-create the interrupts across hibernation, so
> hv_compose_msi_msg() is called automatically. However, some other PCI
> device drivers (e.g. the Nvidia driver) may not destroy and re-create
> the interrupts across hibernation, so hv_pci_resume() has to call
> hv_compose_msi_msg(), otherwise the PCI device drivers can no longer
> receive MSI/MSI-X interrupts after hibernation.
>=20
> Fixes: ac82fc832708 ("PCI: hv: Add hibernation support")
> Cc: Jake Oshins <jakeo@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 44 +++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index fc4c3a15e570..abefff9a20e1 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1211,6 +1211,21 @@ static void hv_irq_unmask(struct irq_data *data)
>  	pbus =3D pdev->bus;
>  	hbus =3D container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
>=20
> +	if (hbus->state =3D=3D hv_pcibus_removing) {
> +		/*
> +		 * During hibernatin, when a CPU is offlined, the kernel tries

s/hiberatin/hibernation/

> +		 * to move the interrupt to the remaining CPUs that haven't
> +		 * been offlined yet. In this case, the below hv_do_hypercall()
> +		 * always fails since the vmbus channel has been closed, so we
> +		 * should not call the hypercall, but we still need
> +		 * pci_msi_unmask_irq() to reset the mask bit in desc->masked:
> +		 * see cpu_disable_common() -> fixup_irqs() ->
> +		 * irq_migrate_all_off_this_cpu() -> migrate_one_irq().
> +		 */
> +		pci_msi_unmask_irq(data);
> +		return;
> +	}
> +
>  	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
>=20
>  	params =3D &hbus->retarget_msi_interrupt_params;
> @@ -3372,6 +3387,33 @@ static int hv_pci_suspend(struct hv_device *hdev)
>  	return 0;
>  }
>=20
> +static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
> +{
> +	struct msi_desc *entry;
> +	struct irq_data *irq_data;
> +
> +	for_each_pci_msi_entry(entry, pdev) {
> +		irq_data =3D irq_get_irq_data(entry->irq);
> +		if (WARN_ON_ONCE(!irq_data))
> +			return -EINVAL;
> +
> +		hv_compose_msi_msg(irq_data, &entry->msg);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Upon resume, pci_restore_msi_state() -> ... ->  __pci_write_msi_msg()
> + * re-writes the MSI/MSI-X registers, but since Hyper-V doesn't trap and
> + * emulate the accesses, we have to call hv_compose_msi_msg() to ask
> + * Hyper-V to re-create the IOMMU Interrupt Remapping Table Entries.
> + */
> +static void hv_pci_restore_msi_state(struct hv_pcibus_device *hbus)
> +{
> +	pci_walk_bus(hbus->pci_bus, hv_pci_restore_msi_msg, NULL);
> +}
> +
>  static int hv_pci_resume(struct hv_device *hdev)
>  {
>  	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
> @@ -3405,6 +3447,8 @@ static int hv_pci_resume(struct hv_device *hdev)
>=20
>  	prepopulate_bars(hbus);
>=20
> +	hv_pci_restore_msi_state(hbus);
> +
>  	hbus->state =3D hv_pcibus_installed;
>  	return 0;
>  out:
> --
> 2.19.1

