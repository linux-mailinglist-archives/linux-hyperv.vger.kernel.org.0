Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A75397AAE
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jun 2021 21:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhFAT3F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Jun 2021 15:29:05 -0400
Received: from mail-bn8nam11on2105.outbound.protection.outlook.com ([40.107.236.105]:20736
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233397AbhFAT3E (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Jun 2021 15:29:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n76cknTRRNKFz7ic3d9quuzwiOJBIB5TADm0LMItWt0Zr83DH/zG5/fhUSY4C0DR7tPugfmQ4dJVF9aLUWfJ470q2Jwo4Wo88qdvtvKtwxCj37NiR+SXPr5FGwXOCRRJsg1WIxr5AvFY/lMhgGWox3+V2IIjO/xEmpqLAkg4P0py/N/SJnIFkEMsr6eXefvjcCNIMMsGK/PxAIqHOz76I2YgorSNhbUbNdDSQ15bMjn1Hn5cCOpTcDrk7Jw7gSfjaiMzD4wt4RypXLOT5N4Q2sywS6++5PtI8JF13kX83vNKHr2tNnWIBlKlVWGpoGOjqAD7uKd3mSAmQuYYYfS5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VexXzwbw6db5Oceumgf9YWfxy4aK+RcB/9rdGjt06sU=;
 b=OOH5Qz4IXL34mcw/I3rsCmjnwIW3qX5ueGeezFhibS7j6QPH/SB9tU3ZkUC/5t+tG/BKJAiVHK5N+6Objytx01OUz8comnjLu2W+K+gvERiBBimrTDSp595R4A7wBZeQ1PCrYmfWj316bLevz1vOe1a6LNvVysuBxSJLLtUYkkCYV+iWGqAZrNqXO2qJPPW2yM+f9+Uh6xhJl6+e7IHN+QK/ufuc1NmUVxaq1DgYfFlZnB++Ul8HIK9fzf2BDki5kPzi1eQaota2Tt8X4XV3fubqZ4z0EmffvJcCbXF3vjtMEaJteZ8XrvcLIGIgPtcshkulSKqqkh4zgJfiqCPoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VexXzwbw6db5Oceumgf9YWfxy4aK+RcB/9rdGjt06sU=;
 b=cMad3D5NXcSF44MxarDrHt0euNCMxlNqfr9TRvQ94K/LRjlD2cb2cDQRoNGHTQNtB5G+lwJmdZuIzRalP3SArkHadUAOxYM6TIQPJDbcYn/YYnDKq6D/9k+51jTUEAarsRJX8R4BUo0l6ygSxUvV4wFBxv1YjmkGjgi+XSfcdZs=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1288.namprd21.prod.outlook.com (2603:10b6:a03:10a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.5; Tue, 1 Jun
 2021 19:27:19 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::fda7:afbd:5f96:a099]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::fda7:afbd:5f96:a099%4]) with mapi id 15.20.4219.008; Tue, 1 Jun 2021
 19:27:19 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Parri <Andrea.Parri@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Move completion variable from stack to heap in
 hv_compose_msi_msg()
Thread-Topic: [PATCH] PCI: hv: Move completion variable from stack to heap in
 hv_compose_msi_msg()
Thread-Index: AQHXRwXUcSr7TOzxAkmxOED9A1jUh6r2K36AgAlpMCA=
Date:   Tue, 1 Jun 2021 19:27:18 +0000
Message-ID: <BY5PR21MB150673A34B431F9311E6FDC5CE3E9@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1620806824-31151-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15931F1698FD128C76219F7DD7249@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15931F1698FD128C76219F7DD7249@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f8b069b0-5117-4ef4-9390-7038e23179fe;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-26T17:53:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [67.168.111.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1ced2bf-687a-43e5-85c1-08d9253345a5
x-ms-traffictypediagnostic: BYAPR21MB1288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB12882DFB3CA60E0B3472C1C7CE3E9@BYAPR21MB1288.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2iYac2jGSBeQFdXjp3VNjdlVoKV8TNZZkKH5nj5MIR6DkB7kNOEJr6idf9tzIyNU9JL/g0eXjrLfpIXIKWUsulDtfAF7+0gpU7UWZj6FT3wLBjh7AxHr6Ev4jRstB3APDaSMERgckmhbmcJH3ofTDtpFx3QPtajmZF4qcRhpLrJCeclh/CLd3i72w7+DO71PPR09nvuFRGVLdJo7SjTfRZHDeCPxgv4MSF6JETkJ89fmFeDgRAXisaYvTjHWjz1mnE871DtJ+SenJNdBOcRiiRKpx6XDH/BTslBPymxbo4gn5nzXmJ9XsBz2xmE0b0pijzrXwk391FKJaL4vb4uiE4ST3Pp0g+Ay6LQxsXjTMFB/uWDVDs9yXL6Bz3GipaQLDkQzLYncpax4xfF9NwLIlq6D58w0U0femgyd0zW6QzK/KA6UN6z/G3Y6BVeZ5PTwrHA5g0fgDqgppbvaSJF+g5hHlMAJQXeO0Odqfi/44f1zLWMmjaggUiHM7AtvEQOZQ8NwUeKgxEJzBQWdJhc+93qjsv2aswXNbjKtLCe2/MPBRXPyrcfy1wSLnj1oxo7ntfQ7ZIDB4jlwIANwevF282EiqouJ4WkKwTuURnp9Y/fGH3+2ibourm3Ir8GgRm12zsOhjS0T7X9k7r1/FpUAmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(8990500004)(86362001)(2906002)(33656002)(316002)(7696005)(71200400001)(55016002)(83380400001)(30864003)(6636002)(6506007)(110136005)(66946007)(8676002)(76116006)(8936002)(478600001)(186003)(921005)(5660300002)(26005)(66476007)(122000001)(82950400001)(66446008)(66556008)(64756008)(38100700002)(82960400001)(52536014)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P0toSrbcplsX/5nFYgnZCErl+wiN8xS+bi68abIGuTFz9O/UHmUiVp1JrDo/?=
 =?us-ascii?Q?oDS3IOKHUJ3Pp4M5SQJplxGafdD5Zjm20mpGD+IrY3Xbn6OJmGrWTuYYdOLf?=
 =?us-ascii?Q?X1SeCloPk3yb3phoveDfnUm6PVBFMijgP2qmvysRNhxds6VULRSa/8G3XSid?=
 =?us-ascii?Q?mD8WrPSQTp9adxeCTPbgUdIK1C5WIMRuYCPMT0/fNj71i02SJKUjaxZNTGaZ?=
 =?us-ascii?Q?w+KA2jTwogneR54AepyZ8MNjdVr2WAPNdNjhnwwH9jUWY2PADgQSq3JYVv10?=
 =?us-ascii?Q?k9xgKaiOsuYJWGF7FnPGXDKYYbO28P3LtpF6vf2qI8K0V8NYGLz7c1zXocob?=
 =?us-ascii?Q?aPuTOy4mkGCfztI6DkmEsnGEtSBNxp7s9Gja/5hAqjKdc/6kwpZdydR7F8uF?=
 =?us-ascii?Q?ZJQ4t0fIBQDrVAUNvIsushQmCbjy9hBDiXdihLXM9fUrcQYnP+riWGxbLlh9?=
 =?us-ascii?Q?+oNTMy2EMH9HSLtjRhFsgStnHQe0wzPH7A2bhe7xp9V3Jwrm9D4DAGWm/zlF?=
 =?us-ascii?Q?JACBvC2if4dWek5DxRlh3BuPa5YRlhZp39o3EhQBHFtE0F7ojCMJY/1vC6xn?=
 =?us-ascii?Q?DsWkLLqSGg4OC3laIfD2CFnBnOdqO+wAVjeHdi6Xqvs/68fGw/OEQRPt3a5w?=
 =?us-ascii?Q?z482UVKhrzqcQUyrdYqNk6Enf7eqrRCqOHDvWexuq1QhijmxoXiBXaNyUfZu?=
 =?us-ascii?Q?mdkMTM+Wwv2p3U4KXEyxWFiosbySGg+u5j6m1gL33hU2A1LZgB7IxArKHS23?=
 =?us-ascii?Q?tyRNuHsvlFmLm/K2yk7Y96Or+aphXrz/WO/FexvKriPs1SFxnPoVEPxwQsy6?=
 =?us-ascii?Q?uWyNlgSkAF5ZNvn4+sDzeC9Fa42IapC6c/YA4GwoVWp847FLt88DJ4Khl1qk?=
 =?us-ascii?Q?X8E7K6tUGghRXmAMH45Tp+xaQOGYbkf6sAqwPYwwE+/YRJ44oeg6EAuGis3A?=
 =?us-ascii?Q?x53NXKVTDcYse9iT8cmJfqShU8lb4i9zrwF0p5s5?=
x-ms-exchange-antispam-messagedata-1: +jrfack+i8kz1eagpCvRroFUgghZ6bKkMWNpbxRhdZG4QSnX44/h5cKdR98djfctrjUHA/yakQKMYNlUayQZQe+73v2mVZKOAT8o120zm7kAj4o5xd3NceI0/vszhNz9cUwX9vlFYRs4ArA9JV2ZBzWpypNxpYtiLaycjxg8w9TRE13NVytknrVMQAQKi0MvLVcPSkHrVOtEUTADokSKDiBG9jqc8wdR328RVLHDCP0YfjWTbnQ3C5RZr8Yp18uSvb84gRBehvWXyOXma5j+tOyj+F8azLXOD9fXoM+DhBGaeUVeQr8I71QwjOoMQNKfsv+MQ7HbCyOUyYB1BzEA3g1j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ced2bf-687a-43e5-85c1-08d9253345a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 19:27:18.9779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHZ/1kY5tDtUvtBP2XdOu4O4C8LYiyRvH8nxaPNBvENIcIaqlVEtGs9DJn9vuScwc83HKPWYaIM/gXiASkTFhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1288
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH] PCI: hv: Move completion variable from stack to heap=
 in
> hv_compose_msi_msg()
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> Wednesday, May 12, 2021 1:07 AM
> >
> > hv_compose_msi_msg() may be called with interrupt disabled. It calls
> > wait_for_completion() in a loop and may exit the loop earlier if the
> > device is being ejected or it's hitting other errors. However the VSP
> > may send completion packet after the loop exit and the completion
> > variable is no longer valid on the stack. This results in a kernel oops=
.
> >
> > Fix this by relocating completion variable from stack to heap, and use
> > hbus to maintain a list of leftover completions for future cleanup if
> necessary.
>=20
> Interesting problem.  I haven't reviewed the details of your implementati=
on
> because I'd like to propose an alternate approach to solving the problem.
>=20
> You have fixed the problem for hv_compose_msi_msg(), but it seems like th=
e
> same problem could occur in other places in pci-hyperv.c where a VMbus
> request is sent, and waiting for the response could be aborted by the dev=
ice
> being rescinded.

The problem in hv_compose_msi_msg() is different to other places, it's a bu=
g in the PCI driver that it doesn't handle the case where the device is eje=
cted (PCI_EJECT). After device is ejected, it's valid that VSP may still se=
nd back completion on a prior pending request.

On the other hand, if a device is rescinded, it's not possible to get a com=
pletion on this device afterwards. If we are still getting a completion, it=
's a bug in the VSP or it's from a malicious host.

I agree if the intent is to deal with a untrusted host, I can follow the sa=
me principle to add this support to all requests to VSP. But this is a diff=
erent problem to what this patch intends to address. I can see they may sha=
re the same design principle and common code. My question on a untrusted ho=
st is: If a host is untrusted and is misbehaving on purpose, what's the poi=
nt of keep the VM running and not crashing the PCI driver?

>=20
> The current code (and with your patch) passes the guest memory address of
> the completion packet to Hyper-V as the requestID.  Hyper-V responds and
> passes back the requestID, whereupon hv_pci_onchannelcallback() treats it=
 as
> the guest memory address of the completion packet.  This all assumes that
> Hyper-V is trusted and that it doesn't pass back a bogus value that will =
be
> treated as a guest memory address.  But Andrea Parri has been updating
> other VMbus drivers (like netvsc and storvsc) to *not* pass guest memory
> addresses as the requestID. The pci-hyperv.c driver has not been fixed in=
 this
> regard, but I think this patch could take big step in that direction.
>=20
> My alternate approach is as follows:
> 1.  For reach PCI VMbus channel, keep a 64-bit counter.  When a VMbus
> message is to be sent, increment the counter atomically, and send the nex=
t
> value as the
> requestID.   The counter will not wrap-around in any practical time perio=
d, so
> the requestIDs are essentially unique.  Or just read a clock value to get=
 a
> unique requestID.
> 2.  Also keep a per-channel list of mappings from requestID to the guest
> memory address of the completion packet.  For PCI channels, there will be
> very few requests outstanding concurrently, so this can be a simple linke=
d list,
> protected by a spin lock.
> 3. Before sending a new VMbus message that is expecting a response, add t=
he
> mapping to the list.  The guest memory address can be for a stack local, =
like
> the current code.
> 4. When the sending function completes, either because the response was
> received, or because wait_for_response() aborted, remove the mapping from
> the linked list.
> 5. hv_pci_onchannelcallback() gets the requestID from Hyper-V and looks i=
t
> up in the linked list.  If there's no match in the linked list, the compl=
etion
> response from Hyper-V is ignored.  It's either a late response or a compl=
etely
> bogus response from Hyper-V.  If there is a match, then the address of th=
e
> completion packet is available and valid.  The completion function will n=
eed to
> run while the spin lock is held on the linked list, so that the completio=
n packet
> address is ensured to remain valid while the completion function executes=
.
>=20
> I don't think my proposed approach is any more complicated that what your
> patch does, and it is a step in the direction of fully hardening the pci-=
hyperv.c
> driver.
>=20
> This approach is a bit different from netvsc and storvsc because those dr=
ivers
> must handle lots of in-flight requests, and searching a linked list in th=
e
> onchannelcallback function would be too slow.  The overall idea is the sa=
me,
> but a different approach is used to generate requestIDs and to map betwee=
n
> requestIDs and guest memory addresses.
>=20
> Thoughts?
>=20
> Michael
>=20
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 97
> > +++++++++++++++++++----------
> >  1 file changed, 65 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index 9499ae3275fe..29fe26e2193c 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -473,6 +473,9 @@ struct hv_pcibus_device {
> >  	struct msi_controller msi_chip;
> >  	struct irq_domain *irq_domain;
> >
> > +	struct list_head compose_msi_msg_ctxt_list;
> > +	spinlock_t compose_msi_msg_ctxt_list_lock;
> > +
> >  	spinlock_t retarget_msi_interrupt_lock;
> >
> >  	struct workqueue_struct *wq;
> > @@ -552,6 +555,17 @@ struct hv_pci_compl {
> >  	s32 completion_status;
> >  };
> >
> > +struct compose_comp_ctxt {
> > +	struct hv_pci_compl comp_pkt;
> > +	struct tran_int_desc int_desc;
> > +};
> > +
> > +struct compose_msi_msg_ctxt {
> > +	struct list_head list;
> > +	struct pci_packet pci_pkt;
> > +	struct compose_comp_ctxt comp;
> > +};
> > +
> >  static void hv_pci_onchannelcallback(void *context);
> >
> >  /**
> > @@ -1293,11 +1307,6 @@ static void hv_irq_unmask(struct irq_data *data)
> >  	pci_msi_unmask_irq(data);
> >  }
> >
> > -struct compose_comp_ctxt {
> > -	struct hv_pci_compl comp_pkt;
> > -	struct tran_int_desc int_desc;
> > -};
> > -
> >  static void hv_pci_compose_compl(void *context, struct pci_response
> *resp,
> >  				 int resp_packet_size)
> >  {
> > @@ -1373,16 +1382,12 @@ static void hv_compose_msi_msg(struct
> irq_data
> > *data, struct msi_msg *msg)
> >  	struct pci_bus *pbus;
> >  	struct pci_dev *pdev;
> >  	struct cpumask *dest;
> > -	struct compose_comp_ctxt comp;
> >  	struct tran_int_desc *int_desc;
> > -	struct {
> > -		struct pci_packet pci_pkt;
> > -		union {
> > -			struct pci_create_interrupt v1;
> > -			struct pci_create_interrupt2 v2;
> > -		} int_pkts;
> > -	} __packed ctxt;
> > -
> > +	struct compose_msi_msg_ctxt *ctxt;
> > +	union {
> > +		struct pci_create_interrupt v1;
> > +		struct pci_create_interrupt2 v2;
> > +	} int_pkts;
> >  	u32 size;
> >  	int ret;
> >
> > @@ -1402,18 +1407,24 @@ static void hv_compose_msi_msg(struct
> irq_data
> > *data, struct msi_msg *msg)
> >  		hv_int_desc_free(hpdev, int_desc);
> >  	}
> >
> > +	ctxt =3D kzalloc(sizeof(*ctxt), GFP_ATOMIC);
> > +	if (!ctxt)
> > +		goto drop_reference;
> > +
> >  	int_desc =3D kzalloc(sizeof(*int_desc), GFP_ATOMIC);
> > -	if (!int_desc)
> > +	if (!int_desc) {
> > +		kfree(ctxt);
> >  		goto drop_reference;
> > +	}
> >
> > -	memset(&ctxt, 0, sizeof(ctxt));
> > -	init_completion(&comp.comp_pkt.host_event);
> > -	ctxt.pci_pkt.completion_func =3D hv_pci_compose_compl;
> > -	ctxt.pci_pkt.compl_ctxt =3D &comp;
> > +	memset(ctxt, 0, sizeof(*ctxt));
> > +	init_completion(&ctxt->comp.comp_pkt.host_event);
> > +	ctxt->pci_pkt.completion_func =3D hv_pci_compose_compl;
> > +	ctxt->pci_pkt.compl_ctxt =3D &ctxt->comp;
> >
> >  	switch (hbus->protocol_version) {
> >  	case PCI_PROTOCOL_VERSION_1_1:
> > -		size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
> > +		size =3D hv_compose_msi_req_v1(&int_pkts.v1,
> >  					dest,
> >  					hpdev->desc.win_slot.slot,
> >  					cfg->vector);
> > @@ -1421,7 +1432,7 @@ static void hv_compose_msi_msg(struct irq_data
> > *data, struct msi_msg *msg)
> >
> >  	case PCI_PROTOCOL_VERSION_1_2:
> >  	case PCI_PROTOCOL_VERSION_1_3:
> > -		size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
> > +		size =3D hv_compose_msi_req_v2(&int_pkts.v2,
> >  					dest,
> >  					hpdev->desc.win_slot.slot,
> >  					cfg->vector);
> > @@ -1434,17 +1445,18 @@ static void hv_compose_msi_msg(struct
> irq_data
> > *data, struct msi_msg *msg)
> >  		 */
> >  		dev_err(&hbus->hdev->device,
> >  			"Unexpected vPCI protocol, update driver.");
> > +		kfree(ctxt);
> >  		goto free_int_desc;
> >  	}
> >
> > -	ret =3D vmbus_sendpacket(hpdev->hbus->hdev->channel,
> &ctxt.int_pkts,
> > -			       size, (unsigned long)&ctxt.pci_pkt,
> > +	ret =3D vmbus_sendpacket(hpdev->hbus->hdev->channel, &int_pkts,
> > +			       size, (unsigned long)&ctxt->pci_pkt,
> >  			       VM_PKT_DATA_INBAND,
> >
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> >  	if (ret) {
> >  		dev_err(&hbus->hdev->device,
> > -			"Sending request for interrupt failed: 0x%x",
> > -			comp.comp_pkt.completion_status);
> > +			"Sending request for interrupt failed: 0x%x", ret);
> > +		kfree(ctxt);
> >  		goto free_int_desc;
> >  	}
> >
> > @@ -1458,7 +1470,7 @@ static void hv_compose_msi_msg(struct irq_data
> > *data, struct msi_msg *msg)
> >  	 * Since this function is called with IRQ locks held, can't
> >  	 * do normal wait for completion; instead poll.
> >  	 */
> > -	while (!try_wait_for_completion(&comp.comp_pkt.host_event)) {
> > +	while (!try_wait_for_completion(&ctxt->comp.comp_pkt.host_event))
> {
> >  		unsigned long flags;
> >
> >  		/* 0xFFFF means an invalid PCI VENDOR ID. */ @@ -1494,10
> +1506,11
> > @@ static void hv_compose_msi_msg(struct irq_data *data, struct
> > msi_msg *msg)
> >
> >  	tasklet_enable(&channel->callback_event);
> >
> > -	if (comp.comp_pkt.completion_status < 0) {
> > +	if (ctxt->comp.comp_pkt.completion_status < 0) {
> >  		dev_err(&hbus->hdev->device,
> >  			"Request for interrupt failed: 0x%x",
> > -			comp.comp_pkt.completion_status);
> > +			ctxt->comp.comp_pkt.completion_status);
> > +		kfree(ctxt);
> >  		goto free_int_desc;
> >  	}
> >
> > @@ -1506,23 +1519,36 @@ static void hv_compose_msi_msg(struct
> irq_data
> > *data, struct msi_msg *msg)
> >  	 * irq_set_chip_data() here would be appropriate, but the lock it
> takes
> >  	 * is already held.
> >  	 */
> > -	*int_desc =3D comp.int_desc;
> > +	*int_desc =3D ctxt->comp.int_desc;
> >  	data->chip_data =3D int_desc;
> >
> >  	/* Pass up the result. */
> > -	msg->address_hi =3D comp.int_desc.address >> 32;
> > -	msg->address_lo =3D comp.int_desc.address & 0xffffffff;
> > -	msg->data =3D comp.int_desc.data;
> > +	msg->address_hi =3D ctxt->comp.int_desc.address >> 32;
> > +	msg->address_lo =3D ctxt->comp.int_desc.address & 0xffffffff;
> > +	msg->data =3D ctxt->comp.int_desc.data;
> >
> >  	put_pcichild(hpdev);
> > +	kfree(ctxt);
> >  	return;
> >
> >  enable_tasklet:
> >  	tasklet_enable(&channel->callback_event);
> > +
> > +	/*
> > +	 * Move uncompleted context to the leftover list.
> > +	 * The host may send completion at a later time, and we ignore this
> > +	 * completion but keep the memory reference valid.
> > +	 */
> > +	spin_lock(&hbus->compose_msi_msg_ctxt_list_lock);
> > +	list_add_tail(&ctxt->list, &hbus->compose_msi_msg_ctxt_list);
> > +	spin_unlock(&hbus->compose_msi_msg_ctxt_list_lock);
> > +
> >  free_int_desc:
> >  	kfree(int_desc);
> > +
> >  drop_reference:
> >  	put_pcichild(hpdev);
> > +
> >  return_null_message:
> >  	msg->address_hi =3D 0;
> >  	msg->address_lo =3D 0;
> > @@ -3076,9 +3102,11 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	INIT_LIST_HEAD(&hbus->children);
> >  	INIT_LIST_HEAD(&hbus->dr_list);
> >  	INIT_LIST_HEAD(&hbus->resources_for_children);
> > +	INIT_LIST_HEAD(&hbus->compose_msi_msg_ctxt_list);
> >  	spin_lock_init(&hbus->config_lock);
> >  	spin_lock_init(&hbus->device_list_lock);
> >  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
> > +	spin_lock_init(&hbus->compose_msi_msg_ctxt_list_lock);
> >  	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
> >  					   hbus->sysdata.domain);
> >  	if (!hbus->wq) {
> > @@ -3282,6 +3310,7 @@ static int hv_pci_bus_exit(struct hv_device
> > *hdev, bool
> > keep_devs)
> >  static int hv_pci_remove(struct hv_device *hdev)  {
> >  	struct hv_pcibus_device *hbus;
> > +	struct compose_msi_msg_ctxt *ctxt, *tmp;
> >  	int ret;
> >
> >  	hbus =3D hv_get_drvdata(hdev);
> > @@ -3318,6 +3347,10 @@ static int hv_pci_remove(struct hv_device
> > *hdev)
> >
> >  	hv_put_dom_num(hbus->sysdata.domain);
> >
> > +	list_for_each_entry_safe(ctxt, tmp, &hbus-
> >compose_msi_msg_ctxt_list, list) {
> > +		list_del(&ctxt->list);
> > +		kfree(ctxt);
> > +	}
> >  	kfree(hbus);
> >  	return ret;
> >  }
> > --
> > 2.27.0

