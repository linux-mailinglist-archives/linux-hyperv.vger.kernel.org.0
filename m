Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24A911CE7B
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Dec 2019 14:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfLLNhy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Dec 2019 08:37:54 -0500
Received: from mail-eopbgr1310108.outbound.protection.outlook.com ([40.107.131.108]:6160
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729428AbfLLNhx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Dec 2019 08:37:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIGhC/PLipgsVv6FyxUKg7ZBu5/NQQ4uWpOsPgsoVM3pS1q/ZSjbzOGouki2A1qtlTRAuFg3lFSb8P4JRnE2hPO23+oowtllYRF+qLuxLlkxRu0UprbxFRWlTf/G1g6rDjSdOhWIAo7d/SPg5EQ3D7HWV1l9Wj7nJxkVw96kEqg8zgLar9NXIqBgju8ePU0zAHvRXRFl16d7fGbxqakh+TSVV4zn+B2GknB/K3tAlVZepD44uZ0aEu+bPYZjHKMTu0FONI0visZ5SOfDjTF0pGcJWcrsAyn/B7XSuNq0V7PnmEWfp6lFmHNBl3J+J1y+B4NvezAzZswa/xDmllsDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7kW9obHpWnq6d+jqOYFJfRMZylMMu4R92+/D5KVNJw=;
 b=SyUgP+9AAescJT0srfHggnxTEsPNuOJue+LdufkEZPAsMdMefINQtUNDjwSpge1lsHAQmkebEHD1123TdA8HoDyXhGzi6qbq6pyp9umKJLKe+t8Gubr7YdWHGTDGpWa4DEdpBhqcG2D/xcKRFMEUjCwQLw6lqw1f7XE06gVdHTR7T0i7ArQebCNsTgxpJBg1LZ7pJPIxSSmdPIPYPEY1LiMX4ZrAhhJmmwq/c4x2dqsn4CwY3tMWDzoYmfkPnic9mWfcPjbu9+CwgZ7QBJwVil9pzr/Y+K49JK1JgQ2/0mcdeM2870RTNERAtqnSNdEnS6Ax92sY+2TGCOKN+TJk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7kW9obHpWnq6d+jqOYFJfRMZylMMu4R92+/D5KVNJw=;
 b=ifZu5tSok8YuF66J+I4wu2plQnJFufPaRX9RpIIP4Zb+k3zuJglzgMEZRNnW0Je8zmm6pMn6HUVOCO7YQ8QpkDAT7EQPfcde6v/kbr1BGd6QSv05WrEdOp90rtPyTl0yp1j12ktd/O7/bIGBnmqePRnP+4VUBmnHyHo9v6lHBYY=
Received: from PS1P15301MB0346.APCP153.PROD.OUTLOOK.COM (10.255.67.139) by
 PS1P15301MB0250.APCP153.PROD.OUTLOOK.COM (10.255.65.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.7; Thu, 12 Dec 2019 13:37:44 +0000
Received: from PS1P15301MB0346.APCP153.PROD.OUTLOOK.COM
 ([fe80::c5bb:5af:a6b6:9f2d]) by PS1P15301MB0346.APCP153.PROD.OUTLOOK.COM
 ([fe80::c5bb:5af:a6b6:9f2d%7]) with mapi id 15.20.2559.009; Thu, 12 Dec 2019
 13:37:44 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>
Subject: RE: [EXTERNAL] Re: [RFC PATCH 4/4] x86/Hyper-V: Add memory hot remove
 function
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 4/4] x86/Hyper-V: Add memory hot
 remove function
Thread-Index: AQHVsDSVAmZoEFWZtkS2Kq1wiU/Phae2K6Og
Date:   Thu, 12 Dec 2019 13:37:43 +0000
Message-ID: <PS1P15301MB03464A08271DC99E0617DF8792550@PS1P15301MB0346.APCP153.PROD.OUTLOOK.COM>
References: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
 <20191210154611.10958-5-Tianyu.Lan@microsoft.com>
 <87mubyc367.fsf@vitty.brq.redhat.com>
In-Reply-To: <87mubyc367.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=tiala@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-12T13:37:41.6440274Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=77b4d887-a426-44da-a9a5-d32c97dc732f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [167.220.255.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca3f40f9-2361-4652-b99b-08d77f0877d9
x-ms-traffictypediagnostic: PS1P15301MB0250:|PS1P15301MB0250:|PS1P15301MB0250:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PS1P15301MB02506E8F07004B6A2608498392550@PS1P15301MB0250.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(396003)(136003)(366004)(199004)(189003)(71200400001)(7696005)(52536014)(5660300002)(8990500004)(76116006)(9686003)(66946007)(55016002)(66476007)(66556008)(64756008)(66446008)(110136005)(81156014)(81166006)(8936002)(2906002)(54906003)(8676002)(33656002)(6636002)(6506007)(186003)(478600001)(4326008)(10290500003)(316002)(26005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:PS1P15301MB0250;H:PS1P15301MB0346.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+hKvRz01hQhd9vZoyeiJZShn3tlnpErqILfkvQUt9SI8dYXlSLn0oIGMrbrAoV/+m851ykEiFMxETj/mGEaSGwLq4XiOdonw7jj3JGO0gZMDLVfyiI5Io8BO6yLvg/Y6Gju7+6VCv1UUlnlQ9NMl23JKC0RmbthqRHYV2MmewF1BylxSx6Ar+knYGTKdVzHCHuHC6er7r1JZtxoMT8uxjA/EY9r6PS9fC8nA3gSkLwv7VyS8TtN0Uj1G5BnJImYPlbd8TtWW3co0Cc0kqy1CrNV3JP6rsge/+AmrB6BervwEGJZf6L4TgaW1RHeIqD2JikGNNyxFGlXPmBlKY0384k2mDtUvrKmNODc9T+z8EN5VXzAg/EV0NBxEiCG2cetDNL614WcEKRJvRu+Hr+3fGByGMEL5vaZhTAy6e2yNvqdSPch/ry1aknzaQArzblq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3f40f9-2361-4652-b99b-08d77f0877d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 13:37:43.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQZi6I5mnB9KkmsAHKjgm2bZ9V3/A/T3CoQuCq4pyu1rlmvrwi6l/m6t8/9rs2/gapXXPEZZ2km7m2yT9kEwaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1P15301MB0250
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>=20
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >
> > @@ -376,6 +391,27 @@ struct dm_hot_add_response {
> >  	__u32 result;
> >  } __packed;
> >
> > +struct dm_hot_remove {
> > +	struct dm_header hdr;
> > +	__u32 virtual_node;
> > +	__u32 page_count;
> > +	__u32 qos_flags;
> > +	__u32 reservedZ;
> > +} __packed;
> > +
> > +struct dm_hot_remove_response {
> > +	struct dm_header hdr;
> > +	__u32 result;
> > +	__u32 range_count;
> > +	__u64 more_pages:1;
> > +	__u64 reservedz:63;
> > +	union dm_mem_page_range range_array[]; } __packed;
> > +
> > +#define DM_REMOVE_QOS_LARGE	 (1 << 0)
> > +#define DM_REMOVE_QOS_LOCAL	 (1 << 1)
> > +#define DM_REMOVE_QoS_MASK       (0x3)
>=20
> Capitalize 'QoS' to make it match previous two lines please.
>=20

Yes, Will fix it.

> > +
> >  /*
> >   * Types of information sent from host to the guest.
> >   */
> > @@ -457,6 +493,13 @@ struct hot_add_wrk {
> >  	struct work_struct wrk;
> >  };
> >
> > +struct hot_remove_wrk {
> > +	__u32 virtual_node;
> > +	__u32 page_count;
> > +	__u32 qos_flags;
> > +	struct work_struct wrk;
> > +};
> > +
> >  static bool hot_add =3D true;
> >  static bool do_hot_add;
> >  /*
> > @@ -489,6 +532,7 @@ enum hv_dm_state {
> >  	DM_BALLOON_UP,
> >  	DM_BALLOON_DOWN,
> >  	DM_HOT_ADD,
> > +	DM_HOT_REMOVE,
> >  	DM_INIT_ERROR
> >  };
> >
> > @@ -515,11 +559,13 @@ struct hv_dynmem_device {
> >  	 * State to manage the ballooning (up) operation.
> >  	 */
> >  	struct balloon_state balloon_wrk;
> > +	struct balloon_state unballoon_wrk;
> >
> >  	/*
> >  	 * State to execute the "hot-add" operation.
>=20
> This comment is stale now.
>=20

Will update. Thanks.

> >  	 */
> >  	struct hot_add_wrk ha_wrk;
> > +	struct hot_remove_wrk hr_wrk;
>=20
> Do we actually want to work struct and all the problems with their
> serialization? Can we get away with one?

I think it's possible to just use one work to handle  all kind of msgs
with a work struct which contains parameters for all dm msgs and identify
the msg type in the work callback function.=20


=20

