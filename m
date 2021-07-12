Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06B23C6363
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jul 2021 21:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhGLTQa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Jul 2021 15:16:30 -0400
Received: from mail-bn1nam07on2126.outbound.protection.outlook.com ([40.107.212.126]:5262
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233758AbhGLTQa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Jul 2021 15:16:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz50X+kk78kzJ8EYIwSgBMNIz+PtV3D6ZauctH7kbeGstSYm/+SXH45a/0FcXqrX/BjQzEAJqMLsB6UtCSPqhtQ0mA1lJvf9I6S4HkHDTsZJBEnGZNqzhJUcSWIvGPRBHJjEnBryqffQ3YFlcl/Txnho8J72jaVkmyVFEE/9Eh1KhCekUGC9u+O31WVz+FtXc1DAnEWDFY5FDnAHM4pDCTus5aLbZo+Yyv/zNWb2zuHtwFVMRKP6nnYq7sTxb6H9iUkz0h4QoU6nlRUaQ+IpNgMeIt77p4RAbxVNd3lWnfUAi04mYEDPr3JOzGcGzDv34g2q0eMv3t9UVMUTKJifNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1HyR2ct+z5fo1bpBE9mmDzzQSll/KeeAsWRlw5Pb2k=;
 b=I91TCaBFVtX1pIYqB0Fhq6YxxwHIKRLvL+I2MqHB3/Wysl5va2KjVSa354oChm3nxFvsr+8kb1mdzWN0Fw6DRUVWXXj2H8Te/TyPA9m7te9t6bYWYHjI42RCRlFzfTU3IyRakEr8omIjc96GUGkytzmfOpn2qYW3KXo7VMW41+vqzotbi+FBdwBN/MLzyJBvTbVeY8Pn5k4ofQ0kwOsAg1V1A/GlwKZMYjMpC3VfHQwEksoKuxlVXHSFbCDQe2FkMtHdCDFy32qFWR4KeC5sOEKdNAVPS2NRrbrFRBGwkjh2DZ5VBilfjch1UTA6QYV94SoQKXuW1MKPbkzjlKORvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1HyR2ct+z5fo1bpBE9mmDzzQSll/KeeAsWRlw5Pb2k=;
 b=Nzue5BVG/fxy7HlfceaBLRRR3/yAiCBogAploHf+Qbpl1qf0v+F1svYSIgArW50sIVEH8K694R87lx1mfEZ0oHMoE3NriAqD9l6J2uTpsbA5Jz+Da6WUs/by9sV8/krfCgCwvMnEbbf22EXf21IxC509bp6/Y3jP4RCX/9p5Res=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0173.namprd21.prod.outlook.com (2603:10b6:300:78::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.5; Mon, 12 Jul
 2021 19:13:39 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::6082:4114:68ee:f569]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::6082:4114:68ee:f569%5]) with mapi id 15.20.4352.007; Mon, 12 Jul 2021
 19:13:39 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>, Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 1/1] PCI: hv: Support for create interrupt v3
Thread-Topic: [PATCH 1/1] PCI: hv: Support for create interrupt v3
Thread-Index: Add0TIVdcQX5pMV/TWWUfz5smDdQ7ADAscqQAACY6qA=
Date:   Mon, 12 Jul 2021 19:13:39 +0000
Message-ID: <MW4PR21MB2002F4DDE234A7BF5CDE7225C0159@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB20025B945D77BBFDF61C6DA8C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
 <MWHPR21MB15933F3AB6C53B11B0257E11D7159@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15933F3AB6C53B11B0257E11D7159@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0427ad34-30ce-4617-8641-271adbc45791;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-12T18:54:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 669d24f9-f03e-4773-457c-08d9456927e6
x-ms-traffictypediagnostic: MWHPR21MB0173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0173BF1400B32F45BD419123C0159@MWHPR21MB0173.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKaXG9dnocCklO1i6Sx7Pbc/kqCc+qvw/7VbsQcdgAoXOSlUcO2sNBjbdPplxu/3DlwfggekKn1Ed9V48szq44q7RQzlAghYYQVuZpqqL37lZNV2AY6lg16gLFmHHwlBzuieqXcLpBprwR3q8cBganHSz46tX6hzFgRWy48Elq5UPGheyP4LlEx5jZtAWZ2v+EymMDCVUoIrdHVyoCrw9BwrwmOeYASBQ/AsZpvnmBw8LO9XCVqza8zQUSv5iynijdGq/EM+rjSf6Y5FLePK+nzlLAk5F4pK+KGYIhj+GLixETsCPdwX084o1+sRwzomV7ty1Hayzzk7bY+yYKBu6Hmlb59uxCIkY08Hw8EFEboyfQtCtZVccTNcKCN50nNZ2H6PBBmiMWVlEIZPfBRQ3wnQlFqRgDCE14ExlDCp3YITFnHBllMfknvrItffcmYbwfgZY708A874asviACDdw0Em6JibG9g/GY4TCnfZZ5NK8bDb5eBTRxpW16opRvwupfB/0q+c/Xq89c0Jo7ITgYRHwLDpY2+1N/NOBPzsZJowatHF5ho2kYw4tFotsW1M8LLu0G4NTIQhavzV/g/D0xUpIpsL2g1GgP6KorC+7aJWYZkOhXeY+tq8I3BHNvszFj7q2CLzX7s0zkSj7mypVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(52536014)(6636002)(71200400001)(55016002)(186003)(64756008)(83380400001)(86362001)(66946007)(66446008)(66556008)(66476007)(9686003)(4326008)(316002)(8990500004)(110136005)(122000001)(7696005)(76116006)(8936002)(54906003)(5660300002)(82960400001)(2906002)(478600001)(82950400001)(38100700002)(10290500003)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wMUrqLxzAhrEDHEpW8iW8CmIYIRIKdt4so95cIuv2cv/JXbwBhHoprWMKag/?=
 =?us-ascii?Q?YYfN56lOwY4S8feXR/0ceRSOsWqnsiHpIGMPM909TtymAi6f0YQqDEPBHoNp?=
 =?us-ascii?Q?4TpojwHZ1HOFh5zxnM1wNvuHo3jNj3SPQFmvBfDmZaEDdT05/GbgldRpzUwJ?=
 =?us-ascii?Q?GW5NRkUYejVHIULVUp+dN7WjVB6m5s3YgeSI+FjW5xxAD1KYxeVevXS3lYlQ?=
 =?us-ascii?Q?Q5WV37vuZlwFdiwsuldFex30HkzhNHq7dKyCqbV+N/fzEk/XEuHpLN7LGko+?=
 =?us-ascii?Q?MNBlKL1jAx+7xerSM3wlCggSU4q1gDkXDjqNloR8xYosE60E7/+zgJLD6YZA?=
 =?us-ascii?Q?+ORQnVgD6Fk9mb1gKWjFoF7mzJkILgYGQSXzsZeYkmFvjnNHk5o5sNHwYCUk?=
 =?us-ascii?Q?JryXxBgKe5+5G0UjlBuUUywz3/UTHn6FTh1wN/5YIQWrQ4BxRoHMRazhPeio?=
 =?us-ascii?Q?sWgvTT0lu6bkYhOoBO/G86dmj1P7u3285IAKGsfDM8fzrZIzaC1+erDUjoFD?=
 =?us-ascii?Q?rYWE/ra3sYSOZs7syT5mU+11pxRKQIgo4QbHqEApsF3oTwxBNvF58FxbBikY?=
 =?us-ascii?Q?P4FJZCdEKDYJTI3AQVoDOj9Rw9GouINfs4irDKn44miZUb8We6UFKpBu6DwZ?=
 =?us-ascii?Q?z+8v+9v1PAnVS66WfNwwlPDqoTllG6uK6nP8B6RogV/dCUIEeyxxx43adfGR?=
 =?us-ascii?Q?R7Ip3a5NU99wHIfASPL3ZAEABhher05R6vJUt9fjor0JcJUImOgWS9rg8tNZ?=
 =?us-ascii?Q?XUKQTxsMCUKRLrRKN4kyheaglX1fF6TESpaieyUlTEf08tas0+O6VA/YHIN/?=
 =?us-ascii?Q?EpHxmKuQ/FCtjY/GYnYBygXnHvLxx35Y2QmSRmwDulMwv1/zEtpe35iAe/2W?=
 =?us-ascii?Q?F2IYEipEZQ3Wnt/zQHhOhbgplSA4XasGd6Oqa3PQYySnceUWtxgyhDUWXLGk?=
 =?us-ascii?Q?U/bVMeMPAznbkyH089MNnPzoWF2aw9e92t9i871eS5AuId4THZIl6332k0I7?=
 =?us-ascii?Q?t1xwhWlZbGesvVDTppxGFrQLZxSWktQuq9D46pPuezarzibtrZZLICQ5MCIj?=
 =?us-ascii?Q?vQgJWZ+w8uizn8Vf9eyJiAPDypeHrSpk/c86q4SndcGDinhajqsFEG0Jljzb?=
 =?us-ascii?Q?ugFW9W8r2BAJF6Lj6APGiq7qN4rbUt5pNKUFYST3RPXDLg4ETnJub0VepC4y?=
 =?us-ascii?Q?Qc7FlBxuHR/ygn3ge2qA6s9CqbZVtrRxxHVBEGlIcuH92zF3mlZvwkQojqsp?=
 =?us-ascii?Q?E1OklCFYhK/FjjCJvX1y4VMdjyeEwIQIpbbGQASogqFs1dgOsF+A82j21DTu?=
 =?us-ascii?Q?UGewvH+Yp1HHjSh8rPuiJwgGgWeqKmFp+6oDB4kcHcoTMGmoZsQT/fAS4LC8?=
 =?us-ascii?Q?RXwwYts+WXhV2cZRLcnaqWMhjJOA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669d24f9-f03e-4773-457c-08d9456927e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 19:13:39.1198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loXdcS4wmWP7lHYjZiAsMaN8P7CkC9m6rXV2tU16y68qENGCFEX8q3DaHoe0qTaOIJoOhsajqWlNjbzf2fhjy6XZ4453TXogBliEW1QGWqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0173
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -64,6 +64,7 @@ enum pci_protocol_version_t {
> >  	PCI_PROTOCOL_VERSION_1_1 =3D PCI_MAKE_VERSION(1, 1),	/* Win10 */
> >  	PCI_PROTOCOL_VERSION_1_2 =3D PCI_MAKE_VERSION(1, 2),	/* RS1 */
> >  	PCI_PROTOCOL_VERSION_1_3 =3D PCI_MAKE_VERSION(1, 3),	/* Vibranium */
> > +	PCI_PROTOCOL_VERSION_1_4 =3D PCI_MAKE_VERSION(1, 4),      /* Fe */
>=20
> It would be better if we can avoid annotating with internal code names.
> Inside of MSFT we tend to forget over time, and people outside usually
> have no idea what they mean.
>=20


Would you like me to just delete the 'Fe' comment or the previous ones as w=
ell?

> > @@ -235,6 +239,21 @@ struct hv_msi_desc2 {
> >  	u16	processor_array[32];
> >  } __packed;
> >
> > +/*
> > + * struct hv_msi_desc3 - 1.3 version of hv_msi_desc
> > + *	Everything is the same as in 'hv_msi_desc2' except that the size
> > + *	of the 'vector_count' field is larger to support bigger vector
>=20
> Actually, it's the "vector" field that's bigger, not "vector_count".

Will update the comment, thanks.

>=20
> > + *	values. For ex: LPI vectors on ARM.
> > + */
> > +struct hv_msi_desc3 {
> > +	u32	vector;
> > +	u8	delivery_mode;
> > +	u8	reserved;
> > +	u16	vector_count;
> > +	u16	processor_count;
> > +	u16	processor_array[32];
> > +} __packed;
> > +
> >  /**
> >   * struct tran_int_desc
> >   * @reserved:		unused, padding
> > @@ -383,6 +402,12 @@ struct pci_create_interrupt2 {
> >  	struct hv_msi_desc2 int_desc;
> >  } __packed;
> >
> > +struct pci_create_interrupt3 {
> > +	struct pci_message message_type;
> > +	union win_slot_encoding wslot;
> > +	struct hv_msi_desc3 int_desc;
> > +} __packed;
> > +
> >  struct pci_delete_interrupt {
> >  	struct pci_message message_type;
> >  	union win_slot_encoding wslot;
> > @@ -1334,26 +1359,55 @@ static u32 hv_compose_msi_req_v1(
> >  	return sizeof(*int_pkt);
> >  }
> >
> > +static void hv_compose_msi_req_get_cpu(struct cpumask *affinity, int *=
cpu,
> > +				       u16 *count)
> > +{
> > +	/*
> > +	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
> > +	 * by subsequent retarget in hv_irq_unmask().
> > +	 */
> > +	*cpu =3D cpumask_first_and(affinity, cpu_online_mask);
> > +	*count =3D 1;
> > +}
> > +
> >  static u32 hv_compose_msi_req_v2(
> >  	struct pci_create_interrupt2 *int_pkt, struct cpumask *affinity,
> >  	u32 slot, u8 vector)
> >  {
> >  	int cpu;
> > +	u16 cpu_count;
> >
> >  	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE2;
> >  	int_pkt->wslot.slot =3D slot;
> >  	int_pkt->int_desc.vector =3D vector;
> >  	int_pkt->int_desc.vector_count =3D 1;
> >  	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
> > -
> > -	/*
> > -	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
> > -	 * by subsequent retarget in hv_irq_unmask().
> > -	 */
> >  	cpu =3D cpumask_first_and(affinity, cpu_online_mask);
>=20
> Shouldn't this line be deleted since the new hv_compose_msi_req_get_cpu()
> function is doing the work?

Yes, this is fixed in v2 that I just sent out.
