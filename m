Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72D91C6793
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2020 07:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgEFFr5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 May 2020 01:47:57 -0400
Received: from mail-eopbgr1320134.outbound.protection.outlook.com ([40.107.132.134]:39168
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbgEFFr4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 May 2020 01:47:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJarKuKyaGxhmZeSysJNPPo7aivqWpEYKlDFB/zyHtRpvvXOiystLTuAkCYDFikBRtst6FusreX1Rn8tp22S4EzYXXn9NDarmE6EhV2wxAgz2bgottWhgepQ2hhJI3UGv+jXJT3XpRpgOP/cGLnt9RhHcMtcd9kMA7sV+Ba8nyFTlacDu+zlgWmNTFc+TZRQLcxhf3aykwBpl9/IZ2LZmdkDj2dylonM+MdNOcxAgFecQgnO/szSJKkpoClpCcxZiz1YZVVUfV+cAPMRsy/Sj4AuuywPNw8L6w68ZcOVDz4bu9qoseF0HBZF4GMva+3JozPMxzV1RQJvbqe804Duew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0rj7Pk+Q0WQlL1DP3OPW+vqT1lvMeO2Aslw6P9F+4M=;
 b=myqxQyIylI6UuiHUNdV4UgApNwY5SFeBIA6qIP/qZHvbzel8koSnBxplHgPM4uzrqnfksrwia+Dsdz/7GKP5gzkxlsKUwbMQMNLG5NO0j4QqTWaLO9MhFzfGWAISJfLXgiWCF3kqHdDpriVOIsWen7Cmm1S0yeI1dDBV+3/E8fjhRCeCnDcjehLJsYTXijkYKEDgETyZw1yRYp/QfW/+dXXxR0+tloGYmXn3zqOv3A0VPVjSQOlsIzT4TjKeRWcrAJ5I6IBvm2m8Wc0f++8fm4Bf4/qBmHDdUQkv7HJlLRpDfh24fEGmcInCctc1vcoGtScGwajs7khmxis/Z2S2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0rj7Pk+Q0WQlL1DP3OPW+vqT1lvMeO2Aslw6P9F+4M=;
 b=YlY5mK0rMCJihEjVaQaVGOk9aV2U/Q8e6jZ61bLLT+CziAK9xWsfYRhw30AsSgVvWhz+jZfLHl6dUKl7TlkaRRIpjldeAV/S9aBvAmuXLvDWvN8k2BOR913IX/hQtgCrmlB4AjUwc74ATPcznm6lrwnYaRxgfJ58ime3yjMo3rE=
Received: from SG2P153MB0213.APCP153.PROD.OUTLOOK.COM (2603:1096:4:8c::10) by
 SG2P153MB0144.APCP153.PROD.OUTLOOK.COM (2603:1096:3:19::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.0; Wed, 6 May 2020 05:47:48 +0000
Received: from SG2P153MB0213.APCP153.PROD.OUTLOOK.COM
 ([fe80::9979:a66f:c953:ce10]) by SG2P153MB0213.APCP153.PROD.OUTLOOK.COM
 ([fe80::9979:a66f:c953:ce10%6]) with mapi id 15.20.3000.011; Wed, 6 May 2020
 05:47:48 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v2 2/2] PCI: hv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state
Thread-Topic: [PATCH v2 2/2] PCI: hv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state
Thread-Index: AQHWH3qw4MujxUY1oUuPITXoNVY1g6iZn3GAgADy9UA=
Date:   Wed, 6 May 2020 05:47:47 +0000
Message-ID: <SG2P153MB02138A9975FF6D57607FF21FBBA40@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
References: <20200501053728.24740-1-weh@microsoft.com>
 <20200505150941.GB16228@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200505150941.GB16228@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=weh@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-06T05:47:46.2967453Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a819b0dd-0e11-43c1-9982-7d1147215961;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2404:f801:9000:1a:6feb::496b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9cdb3c8-f1b7-4f86-70f1-08d7f1810208
x-ms-traffictypediagnostic: SG2P153MB0144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2P153MB01449D4D5F536FD5C046D9D2BBA40@SG2P153MB0144.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9jxri9b9UAMW6o2mny1v5WmFvrQ921wmcrngBOrsh2tEYCO2Iu4bxGVbscBUtQPhseXlggLGLdpdaX/QHSjHF3XUG6CCa/HMhREUPQxcFKfhGKpsMqdDz7fTm3M9X6+tIbV79fgNFUNByytcf+sHT30fxM54oNXJMTFo0KkUlbaMFdhuddPVsir5nMRdP7EKdsTy9SEHCLdqW+4VxShb8KnWt66sU0Wx1Sjr/GALd/08R01j1vmke21gdI3zJJwIkW7XGAz7mtEpSA9py4j0JIKv/VBTmNO6e0dDfCeKJnsSPVb+EkxBjVcvobUwPkPX6YXox0NZYzqSeyAGpoS/11MapX3JXHOJIrq5SclXOyJenPgqr05AirzYQ/yE88HI/2Vd0rwYqMgJan4lU74trsy0Nkp0iXZ1EOmAN3+wHAcHQarz/cQyEXmB4lBBUOUuqiCrhqyQT6wLg+hlJSeGUWFz3IhhjcCPpE/Mf4ek5ZJcJWdVnj6XO2/5RbpQEYPw3bQVxfZl4XRmw8Xk3u8aWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0213.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(33430700001)(64756008)(66446008)(107886003)(76116006)(4326008)(66946007)(10290500003)(54906003)(52536014)(6916009)(82950400001)(66556008)(53546011)(8990500004)(82960400001)(2906002)(66476007)(316002)(7696005)(6506007)(71200400001)(8936002)(186003)(33440700001)(478600001)(5660300002)(8676002)(33656002)(86362001)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SWmyOMIQ1EKLvbX2fItvhJsBCXvdcT0emjuvIW4omPR257ybz37CJuMhMqorIA7W8R2zFQ6wEd99igfuAX+sna+hW4RE3OzO9LN4alLxNOFyMI0b5BjtWLph1DTyMJIqCcddA+Tn4VKbIH++5UVorXpnn7vX7ANj+SiBVGBemwP3hF8Ndp+zZ69FRZEZBbAYwJT9GgcTuLC23b2b7BH9qOTD5SexDe9PicysREGcNVHkBxMS6boNHzPxWWjrehoNgYYLhrI5rOYn0aHmwMBNnopwJ1ru6r2+Ne0mqX37GVJuCOOB0qiKicz7W2gjNu1qTJzgZRrbVZrX22jhKqKDComiTqNf62dhhXab11BTHayrFrN5wPVqztlnfml6X8e/muOpdyjriiP75OwqCO+9Xtr5dw7Xus7vF3ZFbjJdV1LjQZaSDBviDkYTGapQnyB7dJYXhzgBjM7sh2iggcaNnePUTL9sLUsmcxHV1PoqC/yckb5U9+8QI68zWlrjX+O/qj0tsPMtbxYLU6vxZoKG405CWZXt+qBKDmGacGka2UNmtHTBPBAsTmY76kGAFIj2p/kCat0g78HWbu9BVxGiKzvZql4HROIRp5SFp4NcQX2Tzw5XLSHxjz3HAyeIIbyFTS4iVVdQyOoc9Mxyo2OH4KnVlrmRIQUdC7RpAcGWk4Xva2vUP7wrQT4IBo9UZRfYuGdQHdExK7ytbLEWKEmuL1fYjChafuvE47q/Y5QGnCc5k00l7G0ghWW2CUC142kF3aaZktUUXpZaq9DPnBhcz/vr8hXQoUb1Iq4OazdXbF3DnPhWT27C9iwEBZq5gZafC/YFMyKI2lGbyMrfR+0otQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cdb3c8-f1b7-4f86-70f1-08d7f1810208
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 05:47:47.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POitBzVRzp0C7/tX+efWoLDjWTWMCySkNgp/LpeNiATpdHU6VmSacLlzb7OQVBNSIbuCIPDC9aoCm+kxaZh8XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0144
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Tuesday, May 5, 2020 11:10 PM
> To: Wei Hu <weh@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> wei.liu@kernel.org; robh@kernel.org; bhelgaas@google.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Dexuan Cui <decui@microsoft.com>; Michael Kelley
> <mikelley@microsoft.com>
> Subject: Re: [PATCH v2 2/2] PCI: hv: Retry PCI bus D0 entry when the firs=
t
> attempt failed with invalid device state
>=20
> On Fri, May 01, 2020 at 01:37:28PM +0800, Wei Hu wrote:
> > In the case of kdump, the PCI device was not cleanly shut down before
> > the kdump kernel starts. This causes the initial attempt of entering
> > D0 state in the kdump kernel to fail with invalid device state
> > returned from Hyper-V host.
> > When this happens, explicitly call PCI bus exit and retry to enter the
> > D0 state.
> >
> > Signed-off-by: Wei Hu <weh@microsoft.com>
> > ---
> >    v2: Incorporate review comments from Michael Kelley, Dexuan Cui and
> >    Bjorn Helgaas
> >
> >  drivers/pci/controller/pci-hyperv.c | 40
> > +++++++++++++++++++++++++++--
> >  1 file changed, 38 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index e6fac0187722..92092a47d3af 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -2739,6 +2739,8 @@ static void hv_free_config_window(struct
> hv_pcibus_device *hbus)
> >  	vmbus_free_mmio(hbus->mem_config->start,
> PCI_CONFIG_MMIO_LENGTH);  }
> >
> > +static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs);
> > +
> >  /**
> >   * hv_pci_enter_d0() - Bring the "bus" into the D0 power state
> >   * @hdev:	VMBus's tracking struct for this root PCI bus
> > @@ -2751,8 +2753,10 @@ static int hv_pci_enter_d0(struct hv_device
> *hdev)
> >  	struct pci_bus_d0_entry *d0_entry;
> >  	struct hv_pci_compl comp_pkt;
> >  	struct pci_packet *pkt;
> > +	bool retry =3D true;
> >  	int ret;
> >
> > +enter_d0_retry:
> >  	/*
> >  	 * Tell the host that the bus is ready to use, and moved into the
> >  	 * powered-on state.  This includes telling the host which region @@
> > -2779,6 +2783,38 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
> >  	if (ret)
> >  		goto exit;
> >
> > +	/*
> > +	 * In certain case (Kdump) the pci device of interest was
> > +	 * not cleanly shut down and resource is still held on host
> > +	 * side, the host could return invalid device status.
> > +	 * We need to explicitly request host to release the resource
> > +	 * and try to enter D0 again.
> > +	 */
> > +	if (comp_pkt.completion_status < 0 && retry) {
> > +		retry =3D false;
> > +
> > +		dev_err(&hdev->device, "Retrying D0 Entry\n");
> > +
> > +		/*
> > +		 * Hv_pci_bus_exit() calls hv_send_resource_released()
> > +		 * to free up resources of its child devices.
> > +		 * In the kdump kernel we need to set the
> > +		 * wslot_res_allocated to 255 so it scans all child
> > +		 * devices to release resources allocated in the
> > +		 * normal kernel before panic happened.
> > +		 */
> > +		hbus->wslot_res_allocated =3D 255;
>=20
> I'd rather write a specific function eg hv_pci_bus_shutdown() to make it =
explicit.
> Actually, isn't it something that should *always* be _enforced_ at host b=
ridge
> probe time - regardless of the kernel you are booting on ?
>=20

It is only needed in kdump kernel when the normal kernel which just crashed=
=20
failed to deallocate the PCI resources cleanly. All the states have been ta=
ken
care of in the normal kernel without needing this.=20

Wei
=20

