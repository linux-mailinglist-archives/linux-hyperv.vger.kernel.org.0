Return-Path: <linux-hyperv+bounces-606-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FCD7D8A0C
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 23:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4621C20CB2
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10B83D38E;
	Thu, 26 Oct 2023 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X100ac6q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406684426;
	Thu, 26 Oct 2023 21:07:26 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020002.outbound.protection.outlook.com [52.101.56.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A06D93;
	Thu, 26 Oct 2023 14:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddNk+nr3U4yH87aAL/eoEVzuukcOX5whkyGJWFm7NaQrHTKYvmKyybyKWV8Eob7Zg5dFlT/wxvrx4QdeyXoGo9TZlXmlUeaLcB09UQdecFmaSNkzFiS7LH1YpzIhr3m743/E97AwQUujHW7l03b/ScolGKiSm0pB18UtP/2oUflcKKuX1SZuENW0rB5B8HXo5Ro/Spd4tS1nqiCBxatcX+89cru1K1wI6TvhvwH7vrJ6KMWqb83MeOg4o6wKT1AXCqE9XINX0JBbdsSprlyP0TsUXdwOucdb/veOP2gXZq9b+7/kNqR44AQofzovljyZNje2nA1iWaKp6Yt+vJ9riQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPs8eP6IieOQhnqR6klzGP5pDCVR/FSn6BN6LKQyDDE=;
 b=nij0ovTqzjO+UVXpU/2dNggo4ooo8FHRqXw1Q1gScnShUEU7wi+W8CsKejsySY9rZwehHKUkmR+rU4xE6E0XK222RHIxDQvBflHCsIHUtUolDdg1wjKv2WKaZmEd0OD2b+PrsKvxzf8qouZdQroNCdBmXhkZGV++CBG3R5FyCqalvz+PUm3n2EIPZmPUaNlZRw59DlAArtZ9cS8BpauDtx6ZyWH5kME6OulYzpiQTsoXB7R6W+ssOSBDvKSiduPnPGFeKKQjrPrFECkA/WarB3Z/miGdW/xeLG444vXX2Fz0RseV5gXLKJndC4TewY5wGEc4bT9U6zkg396xi+eoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPs8eP6IieOQhnqR6klzGP5pDCVR/FSn6BN6LKQyDDE=;
 b=X100ac6qJaUkvRT2hgsAPCo+MtmNdhsRjELLiJCYMzcZjXBN/DVd65+fRfR1fjxFWBIBaZ7PwY8Y3KxW/k56Ys5O6sfjVHAr6toXOV6UcdC9S9Y3t1X/mJ2tm6srNpVVXc7cfc8E/jfDahq0FeSAyyurf6Ey2+QI+uPbdf6QsX0=
Received: from MN0PR21MB3264.namprd21.prod.outlook.com (2603:10b6:208:37c::19)
 by BL1PR21MB3306.namprd21.prod.outlook.com (2603:10b6:208:39b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.6; Thu, 26 Oct
 2023 21:07:22 +0000
Received: from MN0PR21MB3264.namprd21.prod.outlook.com
 ([fe80::9f51:f462:e8d2:d242]) by MN0PR21MB3264.namprd21.prod.outlook.com
 ([fe80::9f51:f462:e8d2:d242%5]) with mapi id 15.20.6954.005; Thu, 26 Oct 2023
 21:07:22 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Thread-Topic: [PATCH] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Thread-Index: AQHaB5W4U0Kx/aurvkOjV7lIJbHFdbBcSWCAgABHzdA=
Date: Thu, 26 Oct 2023 21:07:22 +0000
Message-ID:
 <MN0PR21MB32641FE761E83A68CC627FFCCEDDA@MN0PR21MB3264.namprd21.prod.outlook.com>
References: <1698274250-653-1-git-send-email-longli@linuxonhyperv.com>
 <20231026094841.39f01d26@hermes.local>
In-Reply-To: <20231026094841.39f01d26@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a803e39c-7cff-470d-8f4d-d1e0f795ac24;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-26T21:05:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3264:EE_|BL1PR21MB3306:EE_
x-ms-office365-filtering-correlation-id: 599e9ca4-451e-4766-eae7-08dbd6678c27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HACY+LjmapsxBbR9uGNyCCXmmfnM70wzKhxWCH8hIuI/eW3qTvZbLEDyW8WvdSl7nWgHLoVcKY6UiASF8xpTU73zWl6Fasw0v5hjBFilwf19jKsONzXROI3qrGTG+sKnG+qud9yNXKwIrV6cL28r0uNQ2+pfRu2RtVitMmkFt7hlg9HUZud8zi8dOozNpgowC8t+sALZmAD3SfkW/zT8yFaTFMEDzN/f2uHPHscw/Ce00ERclEQWrJi8t1Vbt40Ibh8cOW518CYbDULPo5mCdPU0HSD8AaS2VRxMGaPPIahFZ9YZZqqSLyI9j75Mid/gmz1mNW7oYuFnNWIISFZ6805uc+p2xOlmIzOHWEVMH5qRnz7gsGL+HLd7e379Diec7Hey+t71Dbe051ZSO9bd5mN9IQCUbCqEPrnSwLpMSICvNPPC7RR+kU0H+Tn+IcajJc37osjj3UW977eQGKUOKwfvS8dBnqlS/viLsQil58HLh6pOKaiWGj+S39SWz0Kakishrke7EIg6aIR3cNn9uTFZWGV+He5fJ6zN0P2QPQQdaeka6743pr5bzmf9wJdRzyAqs6shI79mWXMc5ioD88wvsv9kofMxpsodyX74iow0+ckEgRtl1SqGZtjmxEuc2+WMOiiRIGJH4jCmmwi6lbp1os2Hj3If2LlNa7QPmKY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3264.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(66556008)(8990500004)(66946007)(83380400001)(316002)(10290500003)(54906003)(38100700002)(76116006)(64756008)(66446008)(110136005)(7696005)(9686003)(82950400001)(26005)(6506007)(66476007)(71200400001)(7416002)(41300700001)(2906002)(8936002)(86362001)(122000001)(4326008)(82960400001)(8676002)(5660300002)(33656002)(478600001)(52536014)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0nnY3Cyh1YOJIV2FpYGEVBjzr55fxlNhOTJAL+aZ+t+P5mAHlSfsncNJ9xYM?=
 =?us-ascii?Q?cbzZ8dEVoXyHSn7g0VAIlmGnNK8aAzpoV7cxCiQapKQx3pUTX+7cFf7/SvFf?=
 =?us-ascii?Q?B8/H6q4HJsQyv9YvtKwpqsIW17mnZ3AjJiLrd9AgKT+Zk5G3ei6ZosAZdJ0a?=
 =?us-ascii?Q?u63vYGgE7GUW3NBjjA/oNZqn3C4Ygcs7KDNny7P40qOU7p9aKGHFkx2vw1QI?=
 =?us-ascii?Q?M4r1tHGtX0Z+fzjuniHHpjdJQtI3VWGExKYX3F0clrFRrTcb+4z+H8/gEttn?=
 =?us-ascii?Q?OmrHBxpWPCO2dCKL7UmnP+z/2QlksRzGQaG3WI+cPyiSLEtWbNNGB5sL9/4W?=
 =?us-ascii?Q?QCY8qevqXG6jUYPoFquDJ6t4IKLL64yEjSRkc9T8H2VIrA1+iYcYr760eESD?=
 =?us-ascii?Q?ZnffyZkOMPPkcoM6K8RzVHLmMgvkMSx5PBC6cUkOFvUZVXz+DUXuc/zKWaI8?=
 =?us-ascii?Q?F1Eaf7aisbFHZyV0QaMC8uuAobDLnFrFunEZSzJKnZiMG3TIpltaQuI6X/fL?=
 =?us-ascii?Q?fvCJ3FX2LQQ6vH1hX/Lao3B57B0DE2E2HuFP/USBJ5NqxwKyNW/z7Idif2yk?=
 =?us-ascii?Q?Vvu7aY136OByIBofE9fPsEZCT1fqEpQooLINW7hPAl58R6PMFAT38lxKf9xw?=
 =?us-ascii?Q?AhdTN8XQpz78JV5N5IuwQHIdejdlRppV4do068DskUBOEFkg9DLRsGacJGJx?=
 =?us-ascii?Q?9dbilT+r0JKb0fqb7rvdU0eK+XMgTfy6QLcpXp0wsb495s6XeChDlsLUULxS?=
 =?us-ascii?Q?lq13HkwRudkuOPpow/LglnB8IVYiJkg6VZERRJMiQ60Fp6ROZJT099P/Bhsj?=
 =?us-ascii?Q?xZC1jxhyd9IzbvVleENzxvPcyHEiUOK79D63VvK0iBP50BODIx8iiyxoly4C?=
 =?us-ascii?Q?NvkuF+kz0KipsEpI/rcqgAp/7enDoc+Cl7C3h6fITDKcoKMOPnk1uSL04JMc?=
 =?us-ascii?Q?pNraQzuHEGmqyqu7aUmzQ1gkQkn+7yYWLwgQmrnp6LGXJVw/EmCopulwiZol?=
 =?us-ascii?Q?phEaQEV7rzSTCPBbefuVxENu6zgtTmU7ZvA7a5NFiiiZ/9gaviz5Ziwnwdxn?=
 =?us-ascii?Q?Fv2RBmbGDP3qlM8YcYFEpO41ISZdj2t246l2to1xzMFu5gGiB63tdFOCJnDk?=
 =?us-ascii?Q?J8vaQlzhlpcFuYacw91JqJRrF5qbxEj9Nagn/i2EjHSiBQ8wqGQlTqZMaiXa?=
 =?us-ascii?Q?eOoQuq3193d+nzUTrGH3IBBYl3fdBXWuibQHK258NuM1h3aRUPaZFRPYmErw?=
 =?us-ascii?Q?c5IiW5prWZ7pjPVOoaYS9dkPBeWvvmAiVqejgqi7ZlQ4lJjm0GWSnEhzctcQ?=
 =?us-ascii?Q?d7BVnn/AREzlmGYhUbs3KI6dyzAQ97XOETdpDvW6iF5HllEU3bUxlVOI8ELg?=
 =?us-ascii?Q?8T/ifJrQtzUg1iAPJKfFcRLi7lhVKVHs0HQH98s544/FFbGF9m+mTA9fDrmC?=
 =?us-ascii?Q?IyNlP35it5xzAwgR8TiKQDSu59zupDuDma0WxVnkwu0761XrvjJj3op6kp94?=
 =?us-ascii?Q?YmsCWVJnN2XdyCBeVfQ9UunH0dCnzat+R6VpsIPoWMf9QF6yq3daEGg0hxTV?=
 =?us-ascii?Q?0uTfGYqLhrNcc24Ep6fzvZbcXOcSZ4wGRzjGm3B3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3264.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599e9ca4-451e-4766-eae7-08dbd6678c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 21:07:22.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrQT2virXgk9Py4XH8gVVUSgbYk+wbUQiAs9p7KoapFlBnjzumFUD79hwz5nXTggkU3lV9acRzRrhZfbr7IV6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3306

> Subject: Re: [PATCH] hv_netvsc: Mark VF as slave before exposing it to us=
er-mode
>=20
> On Wed, 25 Oct 2023 15:50:50 -0700
> longli@linuxonhyperv.com wrote:
>=20
> > @@ -2347,6 +2342,12 @@ static int netvsc_register_vf(struct net_device
> *vf_netdev)
> >  	if (!ndev)
> >  		return NOTIFY_DONE;
> >
> > +	if (event =3D=3D NETDEV_POST_INIT) {
> > +		/* set slave flag before open to prevent IPv6 addrconf */
> > +		vf_netdev->flags |=3D IFF_SLAVE;
> > +		return NOTIFY_DONE;
> > +	}
> > +
> >  	net_device_ctx =3D netdev_priv(ndev);
> >  	netvsc_dev =3D rtnl_dereference(net_device_ctx->nvdev);
> >  	if (!netvsc_dev || rtnl_dereference(net_device_ctx->vf_netdev))
> > @@ -2753,8 +2754,9 @@ static int netvsc_netdev_event(struct notifier_bl=
ock
> *this,
> >  		return NOTIFY_DONE;
> >
> >  	switch (event) {
> > +	case NETDEV_POST_INIT:
> >  	case NETDEV_REGISTER:
> > -		return netvsc_register_vf(event_dev);
> > +		return netvsc_register_vf(event_dev, event);
>=20
> Although correct, this is an awkward way to write this.
> There are two events which call register_vf() but the post init one short=
 circuits
> and doesn't really register the VF.
>=20
> The code is clearer if flag is set in switch statement.
>=20

I will add a dedicated function to handle NETDEV_POST_INIT.

Thanks,
Long

