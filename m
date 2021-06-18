Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5BD3ACC22
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jun 2021 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhFRN2U (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Jun 2021 09:28:20 -0400
Received: from mail-mw2nam10on2125.outbound.protection.outlook.com ([40.107.94.125]:43232
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232740AbhFRN2U (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Jun 2021 09:28:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTPb/Thd+GDXP4gvciTDHhizCy8vG94bydV9p95JW4Q2cw7O5ZbZTaIjCN12NSqFnVvytltw+etxsTfaH7lbiX+QX8uneZhDXwgZ9oLMM0g9i69P8R5pPYZikv21BvbI5Y3n16yKPFIBE6JYO2eXqkxqTv7eVEkWpCBuyD9a4/a2Z8SXluaNB4L62elPbn7jhd7o1cMLpsxrbwGw9hWj338vVBirStOWFyB2Q4Ng3ViwGaySooxaEcequ9LZDGvq6Cy1nPHqFxTJKseDx+1xuA6vVMycCqrOmgame1e+WubRZukOdVn2Hoht8ow5NKz5CMSHcaMzNaHsMNu4pkJLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5X8U0XoT3ysVa4LX1FoKBtCIp8Wd6yHSPcpULxj6xg=;
 b=RjOt3nbL008pA7Ry9BbwFnCmhTu7b1Lq3GIeVIpRvYtZxgKAYw2jRplA/D6Yw+maHONSZMj1vMZLAqgiWPsD93dpytVxvbchOp0DYUFJl9Yh0wIqG0Y+QQGUPY2D3XLGic5QKvEFHG7rxzinGZnz9GUsWdYL5jXmUotIOfM8Y16ptoVumoyVsQSA9zeojRszCUd3Zi1OGjkFleSNWtynVUJijBlUvqWgt2hkCw67ZVOOhuVDZDuOyQ6VT86fQWvcLrQ49NSJzCLtZSbLvymICbUQh1+v5KQbVI5WEG60FYiw9o2udLlaCTYeOKladU7MCdBEOJWS0JsuBxm68Rd9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5X8U0XoT3ysVa4LX1FoKBtCIp8Wd6yHSPcpULxj6xg=;
 b=W+WEQ/5eCUpvQ953qxMhp9mV79ToqYaPEIFnqRkKZKR14Y4srFt2g/tU7oeLD0llUyxvK/Tn5dxzY4EHf5kjE5wmRvXYz99PjpwBFNiWrq68nL2prZLpeJhpBcnXQH+1kGSYoPQmFASo5CGUgPEe6KnAEo7wGoxlh/Gq5wNWZUo=
Received: from MN2PR21MB1295.namprd21.prod.outlook.com (2603:10b6:208:3e::25)
 by MN2PR21MB1407.namprd21.prod.outlook.com (2603:10b6:208:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.3; Fri, 18 Jun
 2021 13:26:06 +0000
Received: from MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::f8d4:8bc1:147:6f40]) by MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::f8d4:8bc1:147:6f40%9]) with mapi id 15.20.4264.013; Fri, 18 Jun 2021
 13:26:06 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pci-hyperv: Add check for hyperv_initialized in
 init_hv_pci_drv()
Thread-Topic: [PATCH] pci-hyperv: Add check for hyperv_initialized in
 init_hv_pci_drv()
Thread-Index: AQHXUbxdC4Kbc7RbE06RxTwA62fpnKsAkZgAgAPbdwCAAN3WgIAUm6MAgAAA0uA=
Date:   Fri, 18 Jun 2021 13:26:06 +0000
Message-ID: <MN2PR21MB12953B17F1C0C9B4F95A6676CA0D9@MN2PR21MB1295.namprd21.prod.outlook.com>
References: <20210602103206.4nx55xsl3nxqt6zj@liuwe-devbox-debian-v2>
 <20210604212622.GA2241239@bjorn-Precision-5520>
 <20210605104021.amywuuhlyesgmybw@liuwe-devbox-debian-v2>
 <20210618132236.lhbszxfgqnv2p4hq@liuwe-devbox-debian-v2>
In-Reply-To: <20210618132236.lhbszxfgqnv2p4hq@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e27a2826-6cec-4830-863c-bddad44f52d4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-18T13:25:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 725f54df-0bcc-4575-d78d-08d9325ca091
x-ms-traffictypediagnostic: MN2PR21MB1407:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MN2PR21MB1407951417390D96169FFFC6CA0D9@MN2PR21MB1407.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOMfJVpVJrUXJmtkzVDJd5ewa3A2/zAHQP2j3nkWM218gIrysycjrJo6lX/1ITNhPMN2gPddtElAYKEkdSww/m0GK5xF/RsNFOykpo482UbfTWaDA/7XJp9RuQ9rQ+s8lHyl7IPN84iRVyxT4aLRyCm5XRLrpRvnbb5nd7NHdJEEn8ndMrCDu7SxU3Rp99H8TOslMX36fYLAHYlgAlB8OloZUH5H2Qpf2JKrQYbSQMe3KHl1raBl8eiXpbj6l1ZgF+ukbQnu7Mmz0yMYvbuBglq5w7wA31kbp17pFAnHk0JaTJFukc0uRYS3seghxaSJfTu39avkshWtmeC8WjuljcsR6iT0DY6SR1CTwXYToRWylD2PEi1HknGYXlWQh7Acuhw8YMoUl8CtePhtN5Uz5a2z/BIIyfp3nh/KskdbB850GdoB2FRZbhWc6wtJsBEqtwWYhz8SQn13YItxxAkjxt02FNBwSn/431DdqAKTykkeIe0yYyygmqXOMb0B77x9zYxLY9/UD/te+VCQYrCeWoSzbXOV86r+DajQOxlLZ7+8xtKK1yl+wznyXdg60GQmglYa/7adGDZNgrTkLy9I17S2ahgw8ExevuZOZrJfEjlk5g8FvxVCd4lX2n3QKF6pkVpbnzTLWK9bfWTLa86gGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1295.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(478600001)(122000001)(71200400001)(83380400001)(76116006)(186003)(86362001)(26005)(38100700002)(9686003)(10290500003)(55016002)(8676002)(6506007)(82950400001)(82960400001)(53546011)(33656002)(5660300002)(66476007)(66556008)(7696005)(110136005)(316002)(64756008)(8936002)(66446008)(54906003)(2906002)(8990500004)(4326008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cCl+GG5U8XRQtyj5E24+k3Dx8FYZmZNMfCYzGY6SH3wcDT3WAVQnUTLka+jD?=
 =?us-ascii?Q?1lwuaeSJxNWWyDIffB2o0tD5vYkG+K+tK7kmn791vV/SZ8VO70s5hXlenJ/M?=
 =?us-ascii?Q?nW7YoeEvkUdbJJsz9Pn6wZyt8VNGKoDsG9FcMBnaCn9eVUo+MLiQ4bXsedtD?=
 =?us-ascii?Q?7v1FjNVrBE+9WuZZFg5v25B86cXDyIor+uRUGPzTeX0bLB3zXthGOM2viaG0?=
 =?us-ascii?Q?P1pbkLbUTTpSLVMD33tXx2yeU/b6XsEl2G6RxTcjklWxhUEbCkmhNSBRAz5I?=
 =?us-ascii?Q?deWgz6kV2/h5Jp4nL2xiH0lvpl+RPAQqvvY7H/zuetN60HiYuodXiBE/DgkG?=
 =?us-ascii?Q?NOfOco3MwTyIF+LiksxtcpcfZt5fvufMj9l5/N6KMyil7jOIfn5oZxa2Ybr+?=
 =?us-ascii?Q?8lMlFBQu8PT3lmRLzxG2LVzJkHxT5QHE5BrsOxH/txE5KDWkO0HTZIu0ib/m?=
 =?us-ascii?Q?s8GkJThwsimgem8xbdd9q49mBxs+nDQVu0SPDG1dFfpVMl5lU5M4yb1Hq91b?=
 =?us-ascii?Q?Nk7wPsL9VS2RYnwY2LVBzwsnhD+CyIK4A+2ZUYWTxGvvnqxD6s5hfQsEyMsM?=
 =?us-ascii?Q?dcl1ByZNTOInuGsQAmUaH3ATwMjda952yn9kf24F8VTauQLixrEVgYSLgRgd?=
 =?us-ascii?Q?2wFgCH8gX5C9IJtLlEc8GtmOyLwNiYEJmfqJXdFD4HTAjHc+euYPCrT+IsxR?=
 =?us-ascii?Q?KkI+cxNJYQLcGvU6GiaV3dRgxG2dLi8hqFy3NUOM/W1xSlaa+5MsrZtIZ7Ls?=
 =?us-ascii?Q?TNRDpOuCGlSM21td9GfljZf6NwN2mOt7QVTrV8Wl71uYFOpLOBuVt7qkeDqi?=
 =?us-ascii?Q?wXCAUY5bnbkZtsRs2AbJ9cu6yzxigbpC8sb0UOF47F6GhqPl2qA/EgDn6IXh?=
 =?us-ascii?Q?uNOdv9IeD7DOKbrDISY/CNGGcQU3uG9Grdi/fNIXzhPFuhL4In8XtZL+SXnM?=
 =?us-ascii?Q?fPNEwL6g733dkdXiSnsyRhKULetAttEcTmVEyTS53GiRbOA0hGK65W03fa9+?=
 =?us-ascii?Q?VfKQ577IAhuFi74lOf24KsvBt6ktXCo9hSG/+yaHAN7ULSjLS3L9VFT0qGWO?=
 =?us-ascii?Q?YJv74+mcI6grA0iEtkcVvuHNVGxdaZOSIliVYoAINjJ24ZOOUMrZJcXZyXi2?=
 =?us-ascii?Q?VBKI+By8yyNiIdFYREcGu8WgwNTrMB/RGQFLDqw/exoR82UmPho/wmb96kjx?=
 =?us-ascii?Q?aIwhD1IdyyqYfRYEWN0GbnfEFcBttq6P0RabMA6IQhcGuNX3JHTP5wbdasj6?=
 =?us-ascii?Q?D2TwMwit0GB2xJFTkGYfAyKY+X9chD8U6rUnR3h7cnl6RGAicoyE8DpywclA?=
 =?us-ascii?Q?ufxtdclcuSKVqReO5YEBRo4s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1295.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725f54df-0bcc-4575-d78d-08d9325ca091
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 13:26:06.0878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVeVSAfbWrFpAL+/iaLRfoGBKur/eIJcg9qKxfdd0s1xTbwP64QDUMG1y9BnP3zErJYlVzUull75P30kRBgvSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1407
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Wei Liu <wei.liu@kernel.org>
> Sent: Friday, June 18, 2021 9:23 AM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Wei Liu <wei.liu@kernel.org>; Haiyang Zhang <haiyangz@microsoft.com>;
> bhelgaas@google.com; lorenzo.pieralisi@arm.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; olaf@aepfle.de; vkuznets <vkuznets@redhat.com>;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] pci-hyperv: Add check for hyperv_initialized in
> init_hv_pci_drv()
>=20
> On Sat, Jun 05, 2021 at 10:40:21AM +0000, Wei Liu wrote:
> > On Fri, Jun 04, 2021 at 04:26:22PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Jun 02, 2021 at 10:32:06AM +0000, Wei Liu wrote:
> > > > On Tue, May 25, 2021 at 04:17:33PM -0700, Haiyang Zhang wrote:
> > > > > Add check for hv_is_hyperv_initialized() at the top of
> > > > > init_hv_pci_drv(), so if the pci-hyperv driver is force-loaded
> > > > > on non Hyper-V platforms, the
> > > > > init_hv_pci_drv() will exit immediately, without any side
> > > > > effects, like assignments to hvpci_block_ops, etc.
> > > > >
> > > > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > > > Reported-and-tested-by: Mohammad Alqayeem
> > > > > <mohammad.alqyeem@nutanix.com>
> > > >
> > > > Hello PCI subsystem maintainers, are you going to take this patch
> > > > or shall I?
> > >
> > > This was mistakenly assigned to me, so I reassigned it back to
> > > Lorenzo.
> > >
> > > If you *do* take this, please at least update it to follow the PCI
> > > commit log conventions, e.g.,
> > >
> > >   PCI: hv: Add check ...
> > >
> > > and wrap the text so it fits in 75 columns.
> >
> > Lorenzo already picked up two Hyper-V PCI patches from Long Li. I
> > think leaving this to him is better.
> >
>=20
> This patch is still missing from pci/hv, so I've picked it up via hyperv-=
next
> (with the adjustments required by Bjorn).

Thank you!

- Haiyang
