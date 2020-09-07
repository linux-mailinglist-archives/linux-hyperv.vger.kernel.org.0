Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD0260501
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Sep 2020 21:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgIGTFF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Sep 2020 15:05:05 -0400
Received: from mail-eopbgr750103.outbound.protection.outlook.com ([40.107.75.103]:30592
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729211AbgIGTFE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Sep 2020 15:05:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3fp6sRXcG4eR0rpa1ZPys3G7ULTIERaowyul92Mt3DRvmuzboozHVYDGuKB3C2L/tiha79UiVPLB8SBZbpjFagjdlvtJm1HVlznHm8t7PpdptW0/WZAIPosBtlRWaLONRMdo5X2fKY+OB1lt2SYjlewI/1gVvPxh92BWdvF4XUIIfVLLDSGa+A9qkU7hJKSU5Dlj6nD4h/pTL+KQasUVwx2NjDmh6On6awTJl46fdg/mW9nUS7tyZBYA1RPBIrzOgoYNqFpF72YkInqGc1u9c4+H7fonhA7YJxMuWtikaTNQuVfhYcRNxl0kLOaFbYzB1VwH/JE+B7KgEz8w9/aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9v4ihdx9HdEJXcqa0c3VBi7xcsKnofMlCqpq9HAnW4=;
 b=PCvnXgnzzhU59NbjlarWwxkKvFADdLwyarns38JXaZFfxU7hYT8JUOpgpQzK4m4VvR/7oSNqYb1zsMznUbU6Wv1uS6ci+3L57FQz5Naa30Efu1w3cj7an87haxSW4L58B6DJK8ATS1TvoY0t4ugK/pF8DAJc8QEtx6cieGKTAFc3fEnFEAR0PbihZnKPdGbd9k/8iPgpFgYGp1FR7+OL+RWsyZ8HZOQA5LuzzsujizTHPZKdfb8tD5rSkw3R34fUbokwCoDG6tPdr0Cnf0yOpGe1tAicwXIdbHhaZfR2Z/soHRPuwJJT7iiLz3na0HLh/Scut+I34o2LsxetRw7olA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9v4ihdx9HdEJXcqa0c3VBi7xcsKnofMlCqpq9HAnW4=;
 b=PqRGBUgebWgFNEBL4CkRfcbNWo3quVVZWuh9cQ5p1VZqjFlnSybcbr/ug/UNMrdOyMCRIzu4ujfSuOu8QnehgiWxmvirrD37SD3zJFjOG45R0qBzBl73KKK+4un4s5MItDMNtqZ6FIVoI/KahY23i4ab481wLYDvFs4SoAJZ3hk=
Received: from MWHPR21MB0864.namprd21.prod.outlook.com (2603:10b6:300:77::18)
 by MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.3; Mon, 7 Sep
 2020 19:05:00 +0000
Received: from MWHPR21MB0864.namprd21.prod.outlook.com
 ([fe80::a97c:96d2:350c:6fcc]) by MWHPR21MB0864.namprd21.prod.outlook.com
 ([fe80::a97c:96d2:350c:6fcc%14]) with mapi id 15.20.3391.004; Mon, 7 Sep 2020
 19:05:00 +0000
From:   Jake Oshins <jakeo@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Topic: [PATCH] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Index: AQHWgzAAK+v+0d2+K0aELsOGS7GgA6ldjLHA
Date:   Mon, 7 Sep 2020 19:04:59 +0000
Message-ID: <MWHPR21MB086421741C0B3B542D22B967AB280@MWHPR21MB0864.namprd21.prod.outlook.com>
References: <20200905025450.45528-1-decui@microsoft.com>
In-Reply-To: <20200905025450.45528-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94e24c3c-36bf-4023-bc58-5e8ed30619e3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-07T19:03:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [73.97.159.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0e30ee1-0d08-48ea-38ff-08d85360eb44
x-ms-traffictypediagnostic: MWHPR21MB1593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB1593011897D5941B4933202AAB280@MWHPR21MB1593.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFc1l46Pv7cDD2NOekVSfMPRKsSrbGsXyChvzpo2heOclxYSZDL9gk9SOMx2j6f3EqWClJ8aZ8tnl5bqgQgsUXBIIiU9NhU1YRYCZyLkfxvAYhofu/CuiqcpDIp55fhS65KYPrCLd3tnpcRMm7quB8ASriE/mpHelyVBgpIOvYVbJwY0aBEYHIHntwRCNn++Sw1KllX1oi/7R9XfYgYEi2nsTsZuy4TFTfhNPo69rO8aQVhvrP1dlplGM8SnRORsLLL/EAMQ/h/yz3/wn7fRgynFvp8/+DnaaHaZBg/1N9Dmtk7Ba3h7D0GIbQEnSuWnjO/o+z70sXjJDAUxY46OGRksGfMabmHceL2xN/cgsgHsGtzZCsELA06eRsFVdqQX6M7B8bwOxR8L8AQXEz38dfHT7OkmhIKgF1DSfOEtnrg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB0864.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(5660300002)(478600001)(9686003)(33656002)(52536014)(10290500003)(86362001)(66556008)(66446008)(8936002)(82950400001)(82960400001)(55016002)(76116006)(64756008)(8676002)(66946007)(66476007)(71200400001)(83380400001)(316002)(110136005)(8990500004)(53546011)(6506007)(6636002)(186003)(7696005)(26005)(2906002)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oWqimmZvUD5Mn9+SSw5DxFe6OW6OF/6JuBWyhiNkCoA5OCbbZS1WhCbciQEJIM33rQRyTZn5qRPMxGCtX5dFzXqmEUjJtUzAp5AghY2MLlaa0VPH19k5WQpHtWajMd8BbbCeRilwE+q8tEjovPUsy+iyKcuplofk5yy0vMxfjNNaxZGLCY9T8Q4OkIy3gOFlAHGDxYvXATUCPp8c0wbo6qwWNoFqBPUtSJU7tIZiFeOxJhTWHbtEDqAT8KMncyk/FhPxewtNJnQET2QO8ypYZibBdAL4jkMYsfd4Idv09sIMA5eDGXxp3maGFKppPmOZSpvU/MJi7fQy3kYdMOltSRJr5Hphsi99YTQZh2Ud0UlpcIYKzfQiDVvSFi7DHdm+3ba7JGH/0T9wK3V3MkQeJmbt0rycOGJR95n+3+c+Rs5inUEkidVAmzKnKp445cZKaF2tFsYaIMKFB34dqedHZYjATYhIim+ZoOVCoOhNrMlXhNCOyG0Ewvuxv3y5BrRMOS6A2OibuCmhVx1hnETmVRctxtRSCApykJXPqN3lALUiVY/b/qKW7UeMTtBDJD9vTi5jWUULIUbLQ24byEvbm7BbVeMc8HCSLlfsH7jbjYMfuLXb9wmegEwYSJ/XwrbSHFTlAzLbcUbFW1TdeCI27g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB0864.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e30ee1-0d08-48ea-38ff-08d85360eb44
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 19:04:59.9748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jh9Ijfy7aPeWyzckPQT+59idNyUbxzmUvAiiawLZirFHPq2TQou/D5B6Wh8ldFebx1GnTEI4sc+WJtNfjQXAbC/YM3ZyhYJ6B+FgUp42fQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1593
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Friday, September 4, 2020 7:55 PM
> To: wei.liu@kernel.org; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> lorenzo.pieralisi@arm.com; bhelgaas@google.com; linux-hyperv@vger.kernel.=
org;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Kelley
> <mikelley@microsoft.com>
> Cc: Dexuan Cui <decui@microsoft.com>; Jake Oshins <jakeo@microsoft.com>
> Subject: [PATCH] PCI: hv: Fix hibernation in case interrupts are not re-c=
reated
>=20
> Hyper-V doesn't trap and emulate the accesses to the MSI/MSI-X registers,=
 and we
> must use hv_compose_msi_msg() to ask Hyper-V to create the IOMMU Interrup=
t
> Remapping Table Entries. This is not an issue for a lot of PCI device dri=
vers (e.g.
> NVMe driver, Mellanox NIC drivers), which destroy and re-create the inter=
rupts
> across hibernation, so
> hv_compose_msi_msg() is called automatically. However, some other PCI dev=
ice
> drivers (e.g. the Nvidia driver) may not destroy and re-create the interr=
upts across
> hibernation, so hv_pci_resume() has to call hv_compose_msi_msg(), otherwi=
se the
> PCI device drivers can no longer receive MSI/MSI-X interrupts after hiber=
nation.
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
> +static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg) {
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
> + * Upon resume, pci_restore_msi_state() -> ... ->
> +__pci_write_msi_msg()
> + * re-writes the MSI/MSI-X registers, but since Hyper-V doesn't trap
> +and
> + * emulate the accesses, we have to call hv_compose_msi_msg() to ask
> + * Hyper-V to re-create the IOMMU Interrupt Remapping Table Entries.
> + */
> +static void hv_pci_restore_msi_state(struct hv_pcibus_device *hbus) {
> +	pci_walk_bus(hbus->pci_bus, hv_pci_restore_msi_msg, NULL); }
> +
>  static int hv_pci_resume(struct hv_device *hdev)  {
>  	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev); @@ -3405,6
> +3447,8 @@ static int hv_pci_resume(struct hv_device *hdev)
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

Reviewed-by: Jake Oshins (jakeo@microsoft.com)

