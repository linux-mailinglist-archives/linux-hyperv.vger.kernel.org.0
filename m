Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BFB391F0A
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 May 2021 20:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhEZS3A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 May 2021 14:29:00 -0400
Received: from mail-bn1nam07on2135.outbound.protection.outlook.com ([40.107.212.135]:38011
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232262AbhEZS27 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 May 2021 14:28:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ07lzDF4XS5/U6jXCPCaBhFY/cB5XQ0gSG4kjYYV+X5tWMp77gELV5lQzBGxIxBWAUf+DRbx5g9ymI+MaX686LTPmuKuFIJ5TFqd4fgT+ZUutgN4yQ8hxJ8A+X235Zl1oyGcN3J/FNCZL+vFuXrh3lENq8OcgGqe6rJT3HSL9YB4TOm1/D1ejOo8BrGWKQVA9pmV0P6vFtstkxrDl9zNpSoLjIhCJ0dze4eBdv+m6I+gWJxVLhnCucyN1tAk7mCmJ09nm+oEcVmrrxwoerbg3zfkUqXmodpXt/mK9R1FY8Af5ejh4gTNRmcoSvc8edAuakTf+iCA88X3E7M9P7ysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urjS8QvMuP4D6j8HOrCSCpXkqh5FsShCNj+kh+HHGt8=;
 b=nz+/PB+rqBF6TjBdF3YRGaDEoOixHrqNDGeOcasHfRC5go0LWH2I4HXqnci+4A/ZE9x+lJoeJ9epI3/9sfwzhnlgYnZD9YRaCWPwvBhvUXyFu7JxT4ndK7e3sESl13lX2PJsxA0zDhkKZ1o1VCSMqfTa60aOSKE7iuKka9ANH3jrg3ClG8QLtmjYsN2WJ6FEvNdeSbfdVBIxM6jy6LDIC8Nh2aMM13R9wpFi4EOzH3xSOKijq1Kt7cq6zSBOjO1xsHr+GCOb4yELUo3uMoEyjA8uI1Mr3rb6Ypbg3F5pguY6uB/X7b0EbKKyVv34iU8ttD/7LfXEo+9gSkXNH5dZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urjS8QvMuP4D6j8HOrCSCpXkqh5FsShCNj+kh+HHGt8=;
 b=Lp2jZ2Al2Eqf5yps/Um40W1Uys42qwM26NBngJjFTnR/dsy++rhuZa6XLIW+7l0BH3I81RkH7krmgb4DpVDoWIPcvtXwrOdasc18olSBNuaoJPlETAiInaoE76E+z+qRus0ejJ7P1vTCZJaZKZuN87/gParxKzwnHkkRAsRBz/o=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1890.namprd21.prod.outlook.com (2603:10b6:303:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.2; Wed, 26 May
 2021 18:27:23 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dc3:55b4:b9b3:11a8]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dc3:55b4:b9b3:11a8%4]) with mapi id 15.20.4173.023; Wed, 26 May 2021
 18:27:23 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Parri <Andrea.Parri@microsoft.com>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Move completion variable from stack to heap in
 hv_compose_msi_msg()
Thread-Topic: [PATCH] PCI: hv: Move completion variable from stack to heap in
 hv_compose_msi_msg()
Thread-Index: AQHXRwXU2behzd4YAUSSAXL6ynC27Kr2IgEg
Date:   Wed, 26 May 2021 18:27:23 +0000
Message-ID: <MWHPR21MB15931F1698FD128C76219F7DD7249@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1620806824-31151-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1620806824-31151-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f8b069b0-5117-4ef4-9390-7038e23179fe;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-26T17:53:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxonhyperv.com; dkim=none (message not signed)
 header.d=none;linuxonhyperv.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6eeac37-aa49-4b5a-3be2-08d92073e81d
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB189053D5878A6268FC0F918CD7249@MW4PR21MB1890.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vbf6B4E6gFgQWn2DqHjcDtEVJV+E52GKxI8MyYRCllROaBVPcZo+dttq3YehTn/sJIXfW85yyM8exwfVWrH6d+HXl/lv9vVRHtQFY53J12nce+oBlhsRJctuV6D+DRo0fn3WULD/Yz/4Y+5lS/tnLAhcvjokogEO7qEI0xRQYTC1O/jOsdQGLAVrmpmF07lkmagMpDlpPzTOOXOIqUTF7x6qtC/HLGgIDCkJtEtn+JtQJ/wjkq8cMqcp44hiPev25D+krtIn3wtRTH6PDZCwWAcxjSlqDNz1rG56lPii2yfPQB8DOpAwguMhzBx9eQEGMpsWFpH69SRs2lZrBBjOWcMZzb1tCp/PA306DotTTwOr/x6t6DYUyYsXKFKBkMlenMW/psNCVotMRmM+/7kw2iEHBuhBjyu5akHve/DluKjw/Y63oGokX43jlAdFwvov0M+lYjBcAdrq5bYhAU4woPMNEraTHX95jBYU3RlrG8yYDB9jzNnJoo/wxEvfdc/FHg0y5unBQoF+YdAZt2B+IACZhY8PL7kMNFTIKNKqDeQYURNFMghSpDhwHx5XVF10b7XEMgi3LjA/Lr1jD5+Ys113ZUzrLybNn97JO6u4PEKgMmBIIe25R9OdUtuBoc0A1Qi/uqgs8sygal1ufh3pBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66476007)(6636002)(66946007)(76116006)(66556008)(7696005)(66446008)(6506007)(86362001)(107886003)(33656002)(55016002)(71200400001)(26005)(4326008)(82960400001)(82950400001)(2906002)(8990500004)(9686003)(8936002)(921005)(52536014)(30864003)(8676002)(38100700002)(122000001)(478600001)(83380400001)(316002)(10290500003)(110136005)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IfMJXS849culmzJLTcTZw6/bdMNYY1sHCgcCjPhHHt6MV9LXXF4NMhLh57Yq?=
 =?us-ascii?Q?ROIQe1gfzUGa1WsdWgLyhU7lobTvvYe4iR7N3BFcW+fSaG1aIknaDUCA6Rta?=
 =?us-ascii?Q?Dk2Bqnwbmg6uBjVDT3SD0gI1M0h5GiHcSI0DEhMaCzOm8zobAiEk2FqfFwq3?=
 =?us-ascii?Q?+0FLRZRbl96StD7ImNNGu/vkjX5hDAbws/moAYd7XMh/X16mZ9Cwv0zp4h14?=
 =?us-ascii?Q?q0HwoyhVCXTNgQAtHVHaU4TIe8QK2urduOPK/yaOtXeWhIVrBHeihf0cjfeO?=
 =?us-ascii?Q?3wfVndOUwEvVPVmVaN04st1NWviYTD7Hzm1MwbkypU+279i4qOfRFPdNZbTK?=
 =?us-ascii?Q?0tGHuFcbSLiDilQsNYJF8Hi2gI57wrPwxq1mlHhvnyaWlzeI5QZh3VFl/Bjw?=
 =?us-ascii?Q?PXvpoqRla3ervpjubxtPR0GaW9LYTWboAZjAPZ3yL8KLPi/Lr31/W0qkLwDT?=
 =?us-ascii?Q?/VfOXpOx06DDrfoGCKlTnVDTRBRVCl52sJl6B1VLWAUR0rdAdDahTwZJivdB?=
 =?us-ascii?Q?k8QI9VBspnaoKiHMdIrc/Z1dQN0A97fKPmtJ8J82x+Z4ra1LoeVeK/vptfDI?=
 =?us-ascii?Q?yZ5Pde2SgnHxTxdfv37cGfJQmnaICM716PHYzLfPMNQbiFK0EPyK2fx/PndX?=
 =?us-ascii?Q?lbaPjv976rZEY5AB5g67hjAbnOL46GhSuEbMzD182s434xDGhZU+cXCnm7zQ?=
 =?us-ascii?Q?cHBUEiGhQDG5mUvWgHYofabO99ZM0pfxPrygLZXEONSfSzpFIr4ZThIU5Zwb?=
 =?us-ascii?Q?JxeJpB/rdegHSqH1umrlSGKQWCzangFMWU09dB5S9zcil7C5a+UDVol2xpBn?=
 =?us-ascii?Q?VjWtgg1NjsFix0PslA103GgOfzRdYqmC0ZcAF+LbAoIbWnz3RANMHG9YXT8j?=
 =?us-ascii?Q?qrJ3TNsJq7EfQWrnRcTKU2710JyQqpIOe6B23SZiZv099H0WZgKCXcVu+zOK?=
 =?us-ascii?Q?94XAxRWixOwNjw6WuEftv+cnqJh14U2WQ1Xet+r8?=
x-ms-exchange-antispam-messagedata-1: UcO2APMBbI1ll1Yzod/PIUCiJmiA035vWi5NyFLtyUhiSpU1t52gNLKppLbjBZV1JwxW58XVZJR7GE5j0Hr3sIcovbqmmv4gIpt9i8SiQ8/brV76lt9TrIijfGqgt5r5waGhNpNHHtPnHLgnPWrShRmjFRYPDo8BU5pmBIcvBfVvvMaLMLnDPTQxg1wgIUh2LZPLvJX3VRZICDWeWf8MUbw0iPLknYytAiaOs1JlAm5M66/Rx6bvLuRT6N1Jfamxpi4rEqlmBVuRQFX3CC2jl7wnCzpyzdxFvIffXOg8YOfPb4bJXfuBbgT/CDSR0CuK/8wGo5D6wYxyTEuy4XwIfBpn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6eeac37-aa49-4b5a-3be2-08d92073e81d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 18:27:23.5124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1pRVksYvFsJVY98ktDtXtJMOtq3YOIfeMek0NbmOc2/DOozwI8SPre/CWp7pYRzEM+5TwvkrF090BN9Z/mxCehvmYyppzAsV2b4+iygbz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1890
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Wednesday, =
May 12, 2021 1:07 AM
>=20
> hv_compose_msi_msg() may be called with interrupt disabled. It calls
> wait_for_completion() in a loop and may exit the loop earlier if the devi=
ce is
> being ejected or it's hitting other errors. However the VSP may send
> completion packet after the loop exit and the completion variable is no
> longer valid on the stack. This results in a kernel oops.
>=20
> Fix this by relocating completion variable from stack to heap, and use hb=
us
> to maintain a list of leftover completions for future cleanup if necessar=
y.

Interesting problem.  I haven't reviewed the details of your implementation
because I'd like to propose an alternate approach to solving the problem.

You have fixed the problem for hv_compose_msi_msg(), but it seems like the
same problem could occur in other places in pci-hyperv.c where a VMbus
request is sent, and waiting for the response could be aborted by the devic=
e
being rescinded.

The current code (and with your patch) passes the guest memory address of
the completion packet to Hyper-V as the requestID.  Hyper-V responds and
passes back the requestID, whereupon hv_pci_onchannelcallback() treats it
as the guest memory address of the completion packet.  This all assumes tha=
t
Hyper-V is trusted and that it doesn't pass back a bogus value that will be
treated as a guest memory address.  But Andrea Parri has been updating
other VMbus drivers (like netvsc and storvsc) to *not* pass guest memory
addresses as the requestID. The pci-hyperv.c driver has not been fixed in t=
his
regard, but I think this patch could take big step in that direction.

My alternate approach is as follows:
1.  For reach PCI VMbus channel, keep a 64-bit counter.  When a VMbus messa=
ge
is to be sent, increment the counter atomically, and send the next value as=
 the
requestID.   The counter will not wrap-around in any practical time period,=
 so
the requestIDs are essentially unique.  Or just read a clock value to get a=
 unique
requestID.
2.  Also keep a per-channel list of mappings from requestID to the guest me=
mory
address of the completion packet.  For PCI channels, there will be very few
requests outstanding concurrently, so this can be a simple linked list, pro=
tected
by a spin lock.
3. Before sending a new VMbus message that is expecting a response, add the
mapping to the list.  The guest memory address can be for a stack local, li=
ke
the current code.
4. When the sending function completes, either because the response was
received, or because wait_for_response() aborted, remove the mapping from
the linked list.
5. hv_pci_onchannelcallback() gets the requestID from Hyper-V and looks it
up in the linked list.  If there's no match in the linked list, the complet=
ion
response from Hyper-V is ignored.  It's either a late response or a complet=
ely
bogus response from Hyper-V.  If there is a match, then the address of the
completion packet is available and valid.  The completion function will nee=
d
to run while the spin lock is held on the linked list, so that the completi=
on
packet address is ensured to remain valid while the completion function
executes.

I don't think my proposed approach is any more complicated that what your
patch does, and it is a step in the direction of fully hardening the
pci-hyperv.c driver.

This approach is a bit different from netvsc and storvsc because those driv=
ers
must handle lots of in-flight requests, and searching a linked list in the
onchannelcallback function would be too slow.  The overall idea is the same=
,
but a different approach is used to generate requestIDs and to map
between requestIDs and guest memory addresses.

Thoughts?

Michael

>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 97 +++++++++++++++++++----------
>  1 file changed, 65 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 9499ae3275fe..29fe26e2193c 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -473,6 +473,9 @@ struct hv_pcibus_device {
>  	struct msi_controller msi_chip;
>  	struct irq_domain *irq_domain;
>=20
> +	struct list_head compose_msi_msg_ctxt_list;
> +	spinlock_t compose_msi_msg_ctxt_list_lock;
> +
>  	spinlock_t retarget_msi_interrupt_lock;
>=20
>  	struct workqueue_struct *wq;
> @@ -552,6 +555,17 @@ struct hv_pci_compl {
>  	s32 completion_status;
>  };
>=20
> +struct compose_comp_ctxt {
> +	struct hv_pci_compl comp_pkt;
> +	struct tran_int_desc int_desc;
> +};
> +
> +struct compose_msi_msg_ctxt {
> +	struct list_head list;
> +	struct pci_packet pci_pkt;
> +	struct compose_comp_ctxt comp;
> +};
> +
>  static void hv_pci_onchannelcallback(void *context);
>=20
>  /**
> @@ -1293,11 +1307,6 @@ static void hv_irq_unmask(struct irq_data *data)
>  	pci_msi_unmask_irq(data);
>  }
>=20
> -struct compose_comp_ctxt {
> -	struct hv_pci_compl comp_pkt;
> -	struct tran_int_desc int_desc;
> -};
> -
>  static void hv_pci_compose_compl(void *context, struct pci_response *res=
p,
>  				 int resp_packet_size)
>  {
> @@ -1373,16 +1382,12 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata, struct
> msi_msg *msg)
>  	struct pci_bus *pbus;
>  	struct pci_dev *pdev;
>  	struct cpumask *dest;
> -	struct compose_comp_ctxt comp;
>  	struct tran_int_desc *int_desc;
> -	struct {
> -		struct pci_packet pci_pkt;
> -		union {
> -			struct pci_create_interrupt v1;
> -			struct pci_create_interrupt2 v2;
> -		} int_pkts;
> -	} __packed ctxt;
> -
> +	struct compose_msi_msg_ctxt *ctxt;
> +	union {
> +		struct pci_create_interrupt v1;
> +		struct pci_create_interrupt2 v2;
> +	} int_pkts;
>  	u32 size;
>  	int ret;
>=20
> @@ -1402,18 +1407,24 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata, struct
> msi_msg *msg)
>  		hv_int_desc_free(hpdev, int_desc);
>  	}
>=20
> +	ctxt =3D kzalloc(sizeof(*ctxt), GFP_ATOMIC);
> +	if (!ctxt)
> +		goto drop_reference;
> +
>  	int_desc =3D kzalloc(sizeof(*int_desc), GFP_ATOMIC);
> -	if (!int_desc)
> +	if (!int_desc) {
> +		kfree(ctxt);
>  		goto drop_reference;
> +	}
>=20
> -	memset(&ctxt, 0, sizeof(ctxt));
> -	init_completion(&comp.comp_pkt.host_event);
> -	ctxt.pci_pkt.completion_func =3D hv_pci_compose_compl;
> -	ctxt.pci_pkt.compl_ctxt =3D &comp;
> +	memset(ctxt, 0, sizeof(*ctxt));
> +	init_completion(&ctxt->comp.comp_pkt.host_event);
> +	ctxt->pci_pkt.completion_func =3D hv_pci_compose_compl;
> +	ctxt->pci_pkt.compl_ctxt =3D &ctxt->comp;
>=20
>  	switch (hbus->protocol_version) {
>  	case PCI_PROTOCOL_VERSION_1_1:
> -		size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
> +		size =3D hv_compose_msi_req_v1(&int_pkts.v1,
>  					dest,
>  					hpdev->desc.win_slot.slot,
>  					cfg->vector);
> @@ -1421,7 +1432,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct
> msi_msg *msg)
>=20
>  	case PCI_PROTOCOL_VERSION_1_2:
>  	case PCI_PROTOCOL_VERSION_1_3:
> -		size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
> +		size =3D hv_compose_msi_req_v2(&int_pkts.v2,
>  					dest,
>  					hpdev->desc.win_slot.slot,
>  					cfg->vector);
> @@ -1434,17 +1445,18 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata, struct
> msi_msg *msg)
>  		 */
>  		dev_err(&hbus->hdev->device,
>  			"Unexpected vPCI protocol, update driver.");
> +		kfree(ctxt);
>  		goto free_int_desc;
>  	}
>=20
> -	ret =3D vmbus_sendpacket(hpdev->hbus->hdev->channel, &ctxt.int_pkts,
> -			       size, (unsigned long)&ctxt.pci_pkt,
> +	ret =3D vmbus_sendpacket(hpdev->hbus->hdev->channel, &int_pkts,
> +			       size, (unsigned long)&ctxt->pci_pkt,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret) {
>  		dev_err(&hbus->hdev->device,
> -			"Sending request for interrupt failed: 0x%x",
> -			comp.comp_pkt.completion_status);
> +			"Sending request for interrupt failed: 0x%x", ret);
> +		kfree(ctxt);
>  		goto free_int_desc;
>  	}
>=20
> @@ -1458,7 +1470,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct
> msi_msg *msg)
>  	 * Since this function is called with IRQ locks held, can't
>  	 * do normal wait for completion; instead poll.
>  	 */
> -	while (!try_wait_for_completion(&comp.comp_pkt.host_event)) {
> +	while (!try_wait_for_completion(&ctxt->comp.comp_pkt.host_event)) {
>  		unsigned long flags;
>=20
>  		/* 0xFFFF means an invalid PCI VENDOR ID. */
> @@ -1494,10 +1506,11 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata, struct
> msi_msg *msg)
>=20
>  	tasklet_enable(&channel->callback_event);
>=20
> -	if (comp.comp_pkt.completion_status < 0) {
> +	if (ctxt->comp.comp_pkt.completion_status < 0) {
>  		dev_err(&hbus->hdev->device,
>  			"Request for interrupt failed: 0x%x",
> -			comp.comp_pkt.completion_status);
> +			ctxt->comp.comp_pkt.completion_status);
> +		kfree(ctxt);
>  		goto free_int_desc;
>  	}
>=20
> @@ -1506,23 +1519,36 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata, struct
> msi_msg *msg)
>  	 * irq_set_chip_data() here would be appropriate, but the lock it takes
>  	 * is already held.
>  	 */
> -	*int_desc =3D comp.int_desc;
> +	*int_desc =3D ctxt->comp.int_desc;
>  	data->chip_data =3D int_desc;
>=20
>  	/* Pass up the result. */
> -	msg->address_hi =3D comp.int_desc.address >> 32;
> -	msg->address_lo =3D comp.int_desc.address & 0xffffffff;
> -	msg->data =3D comp.int_desc.data;
> +	msg->address_hi =3D ctxt->comp.int_desc.address >> 32;
> +	msg->address_lo =3D ctxt->comp.int_desc.address & 0xffffffff;
> +	msg->data =3D ctxt->comp.int_desc.data;
>=20
>  	put_pcichild(hpdev);
> +	kfree(ctxt);
>  	return;
>=20
>  enable_tasklet:
>  	tasklet_enable(&channel->callback_event);
> +
> +	/*
> +	 * Move uncompleted context to the leftover list.
> +	 * The host may send completion at a later time, and we ignore this
> +	 * completion but keep the memory reference valid.
> +	 */
> +	spin_lock(&hbus->compose_msi_msg_ctxt_list_lock);
> +	list_add_tail(&ctxt->list, &hbus->compose_msi_msg_ctxt_list);
> +	spin_unlock(&hbus->compose_msi_msg_ctxt_list_lock);
> +
>  free_int_desc:
>  	kfree(int_desc);
> +
>  drop_reference:
>  	put_pcichild(hpdev);
> +
>  return_null_message:
>  	msg->address_hi =3D 0;
>  	msg->address_lo =3D 0;
> @@ -3076,9 +3102,11 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	INIT_LIST_HEAD(&hbus->children);
>  	INIT_LIST_HEAD(&hbus->dr_list);
>  	INIT_LIST_HEAD(&hbus->resources_for_children);
> +	INIT_LIST_HEAD(&hbus->compose_msi_msg_ctxt_list);
>  	spin_lock_init(&hbus->config_lock);
>  	spin_lock_init(&hbus->device_list_lock);
>  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
> +	spin_lock_init(&hbus->compose_msi_msg_ctxt_list_lock);
>  	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
>  					   hbus->sysdata.domain);
>  	if (!hbus->wq) {
> @@ -3282,6 +3310,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, =
bool
> keep_devs)
>  static int hv_pci_remove(struct hv_device *hdev)
>  {
>  	struct hv_pcibus_device *hbus;
> +	struct compose_msi_msg_ctxt *ctxt, *tmp;
>  	int ret;
>=20
>  	hbus =3D hv_get_drvdata(hdev);
> @@ -3318,6 +3347,10 @@ static int hv_pci_remove(struct hv_device *hdev)
>=20
>  	hv_put_dom_num(hbus->sysdata.domain);
>=20
> +	list_for_each_entry_safe(ctxt, tmp, &hbus->compose_msi_msg_ctxt_list, l=
ist) {
> +		list_del(&ctxt->list);
> +		kfree(ctxt);
> +	}
>  	kfree(hbus);
>  	return ret;
>  }
> --
> 2.27.0

