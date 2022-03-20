Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA344E1A39
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Mar 2022 06:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbiCTFy6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 20 Mar 2022 01:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiCTFy5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 20 Mar 2022 01:54:57 -0400
Received: from apac01-obe.outbound.protection.outlook.com (mail-eastasiaazon11020022.outbound.protection.outlook.com [52.101.128.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F73191F;
        Sat, 19 Mar 2022 22:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8TEYW3SLmW/Yl0JNwZr49DgWVptcQFu0eRnc0m6CUgpu0lhnqgFCGOyn2a3TGRScZzxaolrk3eQnYCE7esGLSVfyXEd9ZqZrlktMzbnDSRK076N6b8O5TDHaQ9GUCs3QXhRq2htAf9uMqGlTS4/a+kjJ8hj9upsPv3iz4FP2JvjBQYawGlA6w5eYEg6KCDK3sgTbb9GBNfv/0lzzWuwgDFJ9BCLgXN8LhOnmR26AswKsUCrskKJf/svHYTZpkAqFo6CoFC07KCUwfSRv2THhblkkU8jgDBYMnAI+vf0I5+FFIfwVVY1e9DyPy7dhkCUAhKfOPisoMYEzZGH9idZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow+AZxNNLOWu7QbToxlpAKBzB02qBmucSgf8O45P0SA=;
 b=m++xJGcREhcPokYdjheqaxJSYY+TkoYszHfphi6skFWc4AgNoa212nq13H5dYo2wa5aHgOfgc5+P0L6B5sgJ8dH6+2D/nTY5Tce+8vM8Ds+raJeA3CJIjGrOfUBwbUJ+zuAUNCwf5R2gJhSYTd0ZXTQTn+Jp5EU0xC4ZToFXBwefuX0rFH3pS4TmSARMjT+s6GC1Va3mLYnQPkwMBJmficAQMgYNXfztqj3WmJm3G3BW6yE3VDWUsZwFuZQAZiwXQMljfF3VpB1aEzhMkwPRXg2vWQbKAkUpnsasup67J3fDmzrR9jHqG6Os0ZK2HTWGRAHDPA6Ivn2+mKdw2IsKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow+AZxNNLOWu7QbToxlpAKBzB02qBmucSgf8O45P0SA=;
 b=j3/07Ag8bcxfKUpw7Nzsnfb7pIzcXyR7JLl0gdFerJM1meKqMFKjDiIAhLdbC8fi8yqPW5ZN0bPDS2q/zMfvWU5KFWzjkIqqCxjaMxjBUWQrhtPaXShDykugcyNq4vnTe/eSX1N8IjR4Z5kZlEGxBgZQSgnCKtQ7pFcKdU2s2WI=
Received: from KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM (2603:1096:820:11::20)
 by KL1P15301MB0245.APCP153.PROD.OUTLOOK.COM (2603:1096:820:8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8; Sun, 20 Mar
 2022 05:53:30 +0000
Received: from KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM
 ([fe80::45e1:56b5:9142:7517]) by KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM
 ([fe80::45e1:56b5:9142:7517%4]) with mapi id 15.20.5102.008; Sun, 20 Mar 2022
 05:53:30 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/2] PCI: hv: Use IDR to generate transaction
 IDs for VMBus hardening
Thread-Topic: [EXTERNAL] [PATCH 1/2] PCI: hv: Use IDR to generate transaction
 IDs for VMBus hardening
Thread-Index: AQHYOvCC7YdFpbE8V0SVWDhoYbPEO6zGVFZwgACKaACAAOgZwA==
Date:   Sun, 20 Mar 2022 05:53:29 +0000
Message-ID: <KL1P15301MB02955B706D6913D6FADA85E8BE159@KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM>
References: <20220318174848.290621-1-parri.andrea@gmail.com>
 <20220318174848.290621-2-parri.andrea@gmail.com>
 <KL1P15301MB0295879FF28B67F3C521FFB3BE149@KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM>
 <20220319155928.GA2951@anparri>
In-Reply-To: <20220319155928.GA2951@anparri>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=652163fa-3b89-408c-929d-91314f80f784;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-20T05:50:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 370b71a8-25a9-4533-da11-08da0a35f609
x-ms-traffictypediagnostic: KL1P15301MB0245:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <KL1P15301MB024541BE52B1679B4BD54D5BBE159@KL1P15301MB0245.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ubesFeh0+GhxxbHbRQHmH8BqAO7wkH1bJksUrV69u8tuL4F2VxhcNwPyHfFh1F+Bhr3BzRObOqBXs0aDj8DD8FFdwQjfZOSPlcIPzacDXhJet97wzEAJyJsrb+5wJMdfYSCaDxixd1M3v+JWDNqPv0SEuiqvOWE2Q9mUwlD/zayO0jHEvTRtLYARgHIDCXT3fqz4dWfqfyXksJjw7hBro8kcKIdBCTlCIp4RcFc4/HrsX0vQnfzQYRGTzi2evl7JIAEsahLgJLv8ojF5/EODVGbKFKxwqdwSupTTpIEjKRXL77y/8gYwuYkVEsZz5WgGB124Iw5Jk375naBIC5Bkyr8LpAxFIWyFscsqDULebb1OB3AHQPxQxDj5FCV63mBUZUiu+8H1/cYUOdgn7YxVO3GZMf2dWDb83FRG4MHP2/GCwZHn5+NmMk01VCWNZTLAYG+AtZ2QvGe3rtxZtmX6Td1Sii7GTazvLaQ7x+WBS/LVk49IusY/zbIxiwQGrGwBh+cosFImszdrHxSLm2GBuC6eQ+Z2khILIo8z9g6DF3bA+DkF7LZM7RnOCV0JnYjZtU4E1KnrdBMKJadTZi6m+bp2rrmjsSSSpn8zHJc9Q3Xy6RMTifu2Fg0x3G0/orkXNqSqgW0YXcOOEYrf0ZZfjCjRdZDbxF002guVGCAu/rGHBNaE16Lmkj7huZ+JUa+aeK3rR4RJKjLlogIh/Mu2x3hjtFoHDtD/rEerrOg6kUlOfmwZ7IFH4vWR3AGPZiGJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(38070700005)(55016003)(8676002)(8936002)(86362001)(8990500004)(4326008)(83380400001)(26005)(186003)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(52536014)(71200400001)(38100700002)(5660300002)(9686003)(508600001)(10290500003)(54906003)(122000001)(316002)(82960400001)(82950400001)(33656002)(6916009)(7696005)(2906002)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xHxyKxx+yZMia/w/ms64QEtLW3BNzKOVsznEXhi8tZXa4A+iOM0a50xQDi/m?=
 =?us-ascii?Q?oKQTVXWeDmj9aSjbtFI0820wSEOAl7fvEUyL/5oDrXudJPMXzAABkc1qIQab?=
 =?us-ascii?Q?aJnN4FDGYSN4aH5E56h361l9gkw9JW3bwuo+q3nzGpecLEWTTTapv/BGgwkb?=
 =?us-ascii?Q?iEg8dkVOr3Pjl1a8NU2LdyT4GMF7hsc5p5uBwsWKMWS5Akrx9/0NTOH3xTJs?=
 =?us-ascii?Q?UhyTnJ1x1BuuS8kTlfNrmzhAzfINzZeNNwGeS7GHReFV1h0hYF110MuUSJFu?=
 =?us-ascii?Q?oi5/OGZfZhJs/rpmj1Ye+j619x3rvfim5kBm8+6YaInj4RQ0Gxi5Ff8L0MTG?=
 =?us-ascii?Q?PPsDuESAqlzfUVm9Cav+4zZofM4vCGD0G/LUvk2vlcSiSs6hVXqa7uoMGaca?=
 =?us-ascii?Q?UT1LZmINy1IZszFvTqlvQzUAJ42B5zL2enaE/7K9PvtHiUnQeu2rHae7q9VS?=
 =?us-ascii?Q?Yuy4NxcZah6oGbtejdPyFORqqZc9RdhihJ0xQdhi6lmWoh/eJ3nTWR1/voGL?=
 =?us-ascii?Q?W78GnLuwLJiV3Hng+nopB3O81iljhQV+bM7wNueCVotgHatOSUnHgJXnx17G?=
 =?us-ascii?Q?jsnflRYta8ImzUutvyOpbbm8eB96bPFHX1NFKj/YU5cRl4W2jBp9uSRSCkEc?=
 =?us-ascii?Q?5MYAl7Wnape+L9WFgQVvIWCauQRnEuufMd0cJckk164uwiCK8+WrgBPDh1Md?=
 =?us-ascii?Q?tmWQGDi1cquLRemD9A/VfWE2f2vmWMtnl08nr4xlJ4f1yG1PrJlQq8i8RRnf?=
 =?us-ascii?Q?LUXYWqEF1qvxy12knaBFkxL7Cjyq5lde3upjPq5VzQsvrDi73elTixL4Qbcc?=
 =?us-ascii?Q?+HvsEKoaKlnswlNV/u7/dyT6EUI267ZpFQZyoi3MNjJWbDPOQIRleixs53H/?=
 =?us-ascii?Q?nsxM46ztoH0SPORtsdyF38yTN+Kj4nquca2vcxj6RWC6+yFeVM0ALAvYyhEx?=
 =?us-ascii?Q?ZYMVlbtl9qB7nTDkpKsUQSIAlkQ2mGgYfUiy/TRjkqoMV+JM1kjBTXY87/gp?=
 =?us-ascii?Q?UmxiKcURie0If4cTdqkFL5U+8V9fk/ddNX+LJz7YdFtbj+STaACmI6UhFl12?=
 =?us-ascii?Q?z62tkki+pjd8/qZFYCIMdphgj5Z9nSsFKEYCZbdKSc3aBaTiJvDd+6bTrN3q?=
 =?us-ascii?Q?5aH+uhBV/KE7D/CSianOVY9CrgwMnR5a5YnqIyCNfSFIoV3fkApL5FJI67pt?=
 =?us-ascii?Q?/HoLGiz7G+zMLshFdAC6Tl210gNlEMPIGBpM8bRCuLhdtOWhqO3vHZoGY9Py?=
 =?us-ascii?Q?QwT0gkOZwD7kQdzfiqFn1VIG3pnlVxhq3lCSvBYGCa43gN5kkI3KwWb4lz3X?=
 =?us-ascii?Q?dRNhYFM8Ql1Wzwic2Ydf50cyP3J5A7iYiqw7Dnz1ZzL03g8b77Qu2TMI0w4t?=
 =?us-ascii?Q?lyI9ICAmPcecvCJ4Dm3zx/kae5kI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 370b71a8-25a9-4533-da11-08da0a35f609
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2022 05:53:29.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTkDkEmh33ZFIJIYAJF2CLAz9M6VgWGiq7PVKITNLjlv31c0M0saGjnDPZEP4BWF4ZcUnMYouBF9Z+wIUJS8Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0245
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Andrea Parri <parri.andrea@gmail.com>
> Sent: 19 March 2022 21:29
> To: Saurabh Singh Sengar <ssengar@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Michael Kelley (LINUX) <mikelley@microsoft.com>;
> Wei Hu <weh@microsoft.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Wilczynski <kw@linux.com>; Bjorn Helgaas <bhelgaas@google.com>; linux-
> pci@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [EXTERNAL] [PATCH 1/2] PCI: hv: Use IDR to generate transact=
ion
> IDs for VMBus hardening
>=20
> > > @@ -1208,6 +1211,27 @@ static void hv_pci_read_config_compl(void
> > > *context, struct pci_response *resp,
> > >  	complete(&comp->comp_pkt.host_event);
> > >  }
> > >
> > > +static inline int alloc_request_id(struct hv_pcibus_device *hbus,
> > > +				   void *ptr, gfp_t gfp)
> > > +{
> > > +	unsigned long flags;
> > > +	int req_id;
> > > +
> > > +	spin_lock_irqsave(&hbus->idr_lock, flags);
> > > +	req_id =3D idr_alloc(&hbus->idr, ptr, 1, 0, gfp);
> >
> > [Saurabh Singh Sengar] Many a place we are using alloc_request_id with
> GFP_KERNEL, which results this allocation inside of spin lock with
> GFP_KERNEL.
>=20
> That's a bug.
>=20
>=20
> > Is this a good opportunity to use idr_preload ?
>=20
> I'd rather fix (and 'simplify' a bit the interface) by doing:
>=20
> static inline int alloc_request_id(struct hv_pcibus_device *hbus, void *p=
tr)
> {
> 	unsigned long flags;
> 	int req_id;
>=20
> 	spin_lock_irqsave(&hbus->idr_lock, flags);
> 	req_id =3D idr_alloc(&hbus->idr, ptr, 1, 0, GFP_ATOMIC);
> 	spin_unlock_irqrestore(&hbus->idr_lock, flags);
> 	return req_id;
> }
>=20
> Thoughts?
[Saurabh Sengar] Yes, if we are fine to use GFP_ATOMIC, this makes perfect =
sense.
Once fixed, please add: Reviewed-by: Saurabh Sengar <ssengar@microsoft.com>

>=20
> Thanks,
>   Andrea
