Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A01F22B2FF
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jul 2020 17:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgGWPwy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jul 2020 11:52:54 -0400
Received: from mail-eopbgr1310107.outbound.protection.outlook.com ([40.107.131.107]:65065
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbgGWPwy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jul 2020 11:52:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RobQBdunBJZcFmaJ2G1Uk4CskpIg3iX7mQfahFADqjBxgMB4Szs9Vuhqq6EuQxETBXHDnoogmL7Ka2HJWEysuhM0nLj4hJazfjeNNRmoppksUWna4/X7v5xeZhY8XNrQ4kRqzrEXSr4tSJQYHVTDg8qgJIRCi2COwM0b2voDkjb2ug7AXGnV9Ipobs9q4sVOTKaonKKZYv9zE+MMRap3ARlptO3uecQJ51bjyS6cgFsC8o0WE+uJnDOJKpsj8WR9wriafxZ/PNvhCcQ7Ogamnx+s2J/x5XYaQJfV6H2o2fbo3aslJjlfC+ptf9PHNHUcf5GYfcTSs6m/lGcuBGXqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5R5VtYwUUeZvsGjF8KXndHgNQTwZIdFQVdRkMBO+VvU=;
 b=EoHSVHGnW6qJM7GaD4o10PbS6uMi98h8C0TcqdCGKrIO9PoupfBzQTYrYYd5anVT7R4tvfeZEh3NkChCqnkFKu2IL0N+QfIjW0UqtygyRQYLiXIxoMEWMJ2azr3Ti0welI2jzNEYJzh26TVK14D15EXRPGBq3ezWQPp5IZLqfdQKcGlAVkMYSUmmzXuawjjrCgEPp3HrDKph8pFYROTZvAcoxxtz7v88F4/0IyMNEetbQPvFgYp88Ab01bw33xfnEUN8QLRGerGoiE+EHZeO6ofxcsrQT7zMTP2TYiGURyoXpL02uiRdHkwXkFMs1Koal1MA7QovPSOHpt7y/p/9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5R5VtYwUUeZvsGjF8KXndHgNQTwZIdFQVdRkMBO+VvU=;
 b=LHN7vPIHNtlnyknAlGERjxiYZqYHbuOE+Tl2p1YIHFvrS+jITZGYm/0Nt9ARKzN2jU8lvH7vFxnRgSpclzQJveZ5pB9W3TZ7Tj4Xo1nUMIyxTJ2Eu0vAw7esMFLvga0S4oqJzbXB3eyrj8Vd2aUahGH+gRXDTbcFqE3P/0171D4=
Received: from SG2P153MB0377.APCP153.PROD.OUTLOOK.COM (2603:1096:0:1::15) by
 SG2P153MB0173.APCP153.PROD.OUTLOOK.COM (2603:1096:3:1a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.1; Thu, 23 Jul 2020 15:52:40 +0000
Received: from SG2P153MB0377.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5e5:3111:30f0:8e01]) by SG2P153MB0377.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5e5:3111:30f0:8e01%3]) with mapi id 15.20.3239.007; Thu, 23 Jul 2020
 15:52:40 +0000
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
Subject: RE: [PATCH v3] PCI: hv: Fix a timing issue which causes kdump to fail
 occasionally
Thread-Topic: [PATCH v3] PCI: hv: Fix a timing issue which causes kdump to
 fail occasionally
Thread-Index: AQHWXLZQKkBIivRwbUGRM5mOrRE316kVC1AAgAA8BwA=
Date:   Thu, 23 Jul 2020 15:52:39 +0000
Message-ID: <SG2P153MB03774814C5D6450238CC4471BB760@SG2P153MB0377.APCP153.PROD.OUTLOOK.COM>
References: <20200718034752.4843-1-weh@microsoft.com>
 <20200723111402.GA8120@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200723111402.GA8120@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-23T15:50:57Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=093cf819-a009-4d61-8eae-9537899e17cd;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2404:f801:9000:1a:6fea::de]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f05aaee-14fd-4269-5feb-08d82f206e04
x-ms-traffictypediagnostic: SG2P153MB0173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2P153MB01736CD111CC5293BEDFB8C6BB760@SG2P153MB0173.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: odLW14zhZrRtUUDjRK+CkhJ6/TczgEB591wOrdjNafKEGonQoj+dxh//ExPgSy5Poi5U5Ke24axvGF2bMCfeIpBhG0P1Ae4MuWy8doTwjZ2XtJunYMQ6UP8rYdAFi+ZFm7eZF3blpukEjSfncLL3T+KYDofQRacgYoGnEyZByv4SD5Tb9GbQ7p4GRuTIQc7dQY5GyjfauZLZuPzlxu0vdu9CIHkV2TJcw3iL4wxzVcA+BHneIHn+7fiT7a9yElAOMpQdUjOUgytLqOdBcUPU9qcGUKkFMSH4Q2Av1SWbXDiggJFWjxIdZgTS3qiale1COrJubhtshHyQdrnp8ZDCYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0377.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(5660300002)(52536014)(10290500003)(71200400001)(66556008)(66476007)(186003)(66946007)(82950400001)(82960400001)(76116006)(64756008)(86362001)(66446008)(8676002)(8936002)(55016002)(2906002)(107886003)(33656002)(7696005)(8990500004)(6506007)(4326008)(83380400001)(9686003)(6916009)(54906003)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +INkK3ZSHoI9Hag/CcoXV60wZywtsB6pvnFKPFfIBtRxJ41gPv5gp01MCS547pAQ+gVRfoMIXykvtQfMYvpn46/C4HbLehEJuF3kBF1RaDaEoJoWqB7wPIUeyxP03ochyWpNMwDJARqG/akGQiYdhyA4xcOzAjZEQmXEnJwtAoTv/HyKbr9HY17xiAIVLNG4lbD988U6OJwXuqzRhYKiNQLPJXILSE138kGJs343RcfvC+oXNec+hRspUh56a883GRMM5r4SAmha/YWwRWjz6tvujFC2TRFlgFrcACjpxGN8ZMSwothbZkn4aTdQZJcC6EAxK5bFkGjMTG+0lyGIFVPUM/reIVzLRfeZ981fqnDx/+hQWr7DZpW0vAPwLnYzP10f5Fyv0Oba9Fm38M6rjZ5XdwnVAJkGVhy5sDYN+vgDsGc20voudxOYtZXdQxncUXVqyUb4sGwK9wxuZXuFCub3Tq8TQQz//RVqLyvH53U+4rsVi/QPk+qPpqjXtS8kZMwoP84kuuWa5P/HDLVmpCBk23sCJajtTfa8opPVWXQe4Ju6t07FNiNA5KSsUrC3cv7K2ROqXKg29ImrEzC6ji9VGYu5Ap/ZjcmukXR1Fc6RmmKbZP5kMP8+q1CJgYqArwJG3W5SaWyUBRAK66RVoqEbqA9/9ElNAqdQgr2tWifPPLxnodNZeAszrctj7H56
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0377.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f05aaee-14fd-4269-5feb-08d82f206e04
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 15:52:39.9514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCeC/hSxXsMx5ofY2JP39/zu9yh4ZxZmr/L/7UuOffaBGDEuih5ueEbRg5PzU/Px34rXwgyIvtk35S2uLbANkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0173
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Kdump could fail sometime on Hyper-V guest over Accelerated Network
> > interface. This is because the retry in hv_pci_enter_d0() relies on an
> > asynchronous host event arriving before the guest calls
> > hv_send_resources_allocated(). Fix the problem by moving retry to
> > hv_pci_probe(), removing this dependency and making the calling
> > sequence synchronous.
>=20
> You have to explain why this code move fixes the problem

How about following commit message:

Kdump could fail sometime on Hyper-V guest over Accelerated Network
nterface. This is because the retry in hv_pci_enter_d0() relies on an
asynchronous host event arriving before the guest calls
hv_send_resources_allocated(). Fix the problem by moving retry to
hv_pci_probe() and start the retry from hv_pci_query_relations() call.=20
This causes the host to generate an synchronous event, hence removing=20
this unreliable dependency.
=20
> and you also have to
> add a comment to the code so that anyone who has to fix it in the future =
can
> understand why the code is where you are moving it to and why that's a
> solution.

It already has the comment in the code as:
+	 * The retry should start from hv_pci_query_relations() call.

It would be a bug if the retry does not start from this according to the ho=
st
Behaviour. So I think no further explanation would be needed.

>=20
> > Fixes: c81992e7f4aa ("PCI: hv: Retry PCI bus D0 entry on invalid
> > device state")
> > Signed-off-by: Wei Hu <weh@microsoft.com>
>=20
> Please carry tags and send patches -in-reply-to the previous version to a=
llow
> threading.
>=20

Do you mean to add review-by tags? If not would you please elaborate what
'carry tags' means? Sorry I am not familiar to this term.

Thanks,
Wei


> Thanks,
> Lorenzo
>=20
> > ---
> >     v2: Adding Fixes tag according to Michael Kelley's review comment.
> >     v3: Fix couple typos and reword commit message to make it clearer.
> >     Thanks the comments from Bjorn Helgaas.
> >
> >  drivers/pci/controller/pci-hyperv.c | 66
> > ++++++++++++++---------------
> >  1 file changed, 32 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index bf40ff09c99d..738ee30f3334 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -2759,10 +2759,8 @@ static int hv_pci_enter_d0(struct hv_device
> *hdev)
> >  	struct pci_bus_d0_entry *d0_entry;
> >  	struct hv_pci_compl comp_pkt;
> >  	struct pci_packet *pkt;
> > -	bool retry =3D true;
> >  	int ret;
> >
> > -enter_d0_retry:
> >  	/*
> >  	 * Tell the host that the bus is ready to use, and moved into the
> >  	 * powered-on state.  This includes telling the host which region @@
> > -2789,38 +2787,6 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
> >  	if (ret)
> >  		goto exit;
> >
> > -	/*
> > -	 * In certain case (Kdump) the pci device of interest was
> > -	 * not cleanly shut down and resource is still held on host
> > -	 * side, the host could return invalid device status.
> > -	 * We need to explicitly request host to release the resource
> > -	 * and try to enter D0 again.
> > -	 */
> > -	if (comp_pkt.completion_status < 0 && retry) {
> > -		retry =3D false;
> > -
> > -		dev_err(&hdev->device, "Retrying D0 Entry\n");
> > -
> > -		/*
> > -		 * Hv_pci_bus_exit() calls hv_send_resource_released()
> > -		 * to free up resources of its child devices.
> > -		 * In the kdump kernel we need to set the
> > -		 * wslot_res_allocated to 255 so it scans all child
> > -		 * devices to release resources allocated in the
> > -		 * normal kernel before panic happened.
> > -		 */
> > -		hbus->wslot_res_allocated =3D 255;
> > -
> > -		ret =3D hv_pci_bus_exit(hdev, true);
> > -
> > -		if (ret =3D=3D 0) {
> > -			kfree(pkt);
> > -			goto enter_d0_retry;
> > -		}
> > -		dev_err(&hdev->device,
> > -			"Retrying D0 failed with ret %d\n", ret);
> > -	}
> > -
> >  	if (comp_pkt.completion_status < 0) {
> >  		dev_err(&hdev->device,
> >  			"PCI Pass-through VSP failed D0 Entry with
> status %x\n", @@
> > -3058,6 +3024,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	struct hv_pcibus_device *hbus;
> >  	u16 dom_req, dom;
> >  	char *name;
> > +	bool enter_d0_retry =3D true;
> >  	int ret;
> >
> >  	/*
> > @@ -3178,11 +3145,42 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	if (ret)
> >  		goto free_fwnode;
> >
> > +retry:
> >  	ret =3D hv_pci_query_relations(hdev);
> >  	if (ret)
> >  		goto free_irq_domain;
> >
> >  	ret =3D hv_pci_enter_d0(hdev);
> > +	/*
> > +	 * In certain case (Kdump) the pci device of interest was
> > +	 * not cleanly shut down and resource is still held on host
> > +	 * side, the host could return invalid device status.
> > +	 * We need to explicitly request host to release the resource
> > +	 * and try to enter D0 again.
> > +	 * The retry should start from hv_pci_query_relations() call.
> > +	 */
> > +	if (ret =3D=3D -EPROTO && enter_d0_retry) {
> > +		enter_d0_retry =3D false;
> > +
> > +		dev_err(&hdev->device, "Retrying D0 Entry\n");
> > +
> > +		/*
> > +		 * Hv_pci_bus_exit() calls hv_send_resources_released()
> > +		 * to free up resources of its child devices.
> > +		 * In the kdump kernel we need to set the
> > +		 * wslot_res_allocated to 255 so it scans all child
> > +		 * devices to release resources allocated in the
> > +		 * normal kernel before panic happened.
> > +		 */
> > +		hbus->wslot_res_allocated =3D 255;
> > +		ret =3D hv_pci_bus_exit(hdev, true);
> > +
> > +		if (ret =3D=3D 0)
> > +			goto retry;
> > +
> > +		dev_err(&hdev->device,
> > +			"Retrying D0 failed with ret %d\n", ret);
> > +	}
> >  	if (ret)
> >  		goto free_irq_domain;
> >
> > --
> > 2.20.1
> >
