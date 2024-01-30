Return-Path: <linux-hyperv+bounces-1483-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C290B842F53
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 23:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10BFB2209E
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 22:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0297D41B;
	Tue, 30 Jan 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fZe7VOnN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11020003.outbound.protection.outlook.com [40.93.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D77D410;
	Tue, 30 Jan 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652327; cv=fail; b=SR2qHHTDywbAwdwBhUyGDoG7gG5jLHS6oK4zOLrDqAKYfiDd2cl/vbU/9eraPz8Fw2dqxUghkIQN4V/9gOagWHXdDnemCzcC4rnsTR2Vky6Fdze7/F70kVflI+bUIcCpAaUK8qoymAVor3P3nkNisLhEsZdQ0XLNe42i+jsCBpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652327; c=relaxed/simple;
	bh=qFi72R8WK9xNVon0e9FIzlu4pPS83cGKWKsLLsco0g8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SzgdrCg++nSSxM50afRp9cKlwA6SnEJSSXBqSVsfMY3+uA3jm03+e7taS+XtyrdODNByaEScb22/yk3D38G9NhYREOGdUdbLrZto8JOWI2CTapRB93101wmYKZzMak1fXSJp4UqH1Jjt5AFdPTAaHLtfttWo61qaTYGhkyYBDN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fZe7VOnN; arc=fail smtp.client-ip=40.93.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEZG9MBz0EDNDgmmeat+tWMCwbuCey7kdkbMC5rHYjEtPmgZ5/Dd0J7eZ5na0cQnqHNEpB5pqCaXjULz3oi4QEWTXxxdaiGkMqjZiUCsj1EV2eu1zkTdc/zqOdOAwXyuhqcgqhv+PbUXDP4DoMh2cfbojeHD21P7defj1tSwlPeL4tjs59Ui4CZaDcl/FEmeXfi6BQtNcBz7AXNNt/pSVatFEpwlJl5vKTfVLRZxOoMV99chej35aL7HwMhzxFZGQ6wEUPGp2vp0cy+FPm+VGuI6AmFw9nh762pP4VMv+iETJ5cfUlxBRvAjegoDDJaBYYYPk+KXrdgd8N4IQnjdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP36Wr8qHochEbbbgKZ5aRAFUcp2L+FIAYxMr1bnWW8=;
 b=UpAAY9ZolHUj02tuVFviFcD3Q0sS3J38TVvC+I7+S/pHXqkPh3fWY28EfLKRe2mflm0iYblf9foDAg0P10E8CfEGM8ksbdZEt7YFNdJ6TAFedSK6pBYQlOy44kBqr2u4VulWpRnI4Q0RisVB76cPvUmHXUsNdAmcwrnvOvdg1onWdvG1sVeZndZwEFNM+A6jhbXsN1Chf0sKeTUttd+gmyEjkyow9aACyBbSSTAcgiLX1mG3qSvNFcwh+//La2oID45WS03zVmi5Fx/2flDAE4D9/JSao9Y8B18VBMLCimwL85f5wpdoiSGkUdMmIzAXwJpr+6zlAdJNqBxr+5ro1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP36Wr8qHochEbbbgKZ5aRAFUcp2L+FIAYxMr1bnWW8=;
 b=fZe7VOnNiLuLZPZiLbK0mOiwDPNgIxeK9d3QVHG9HKyIeAa3jruKOffxkP5UP3HLZCZDcGCTVD00o0R7DjGhObAeOQuJo78C3t2o9/PQ5BthF+u8huSfDodYSniWfMMCRNwBCgtjenCFcnl817sX/6jLxZk2WLOaVSajfX+ABaU=
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 (2603:10b6:2c:400:0:3:0:10) by SJ1PR21MB3722.namprd21.prod.outlook.com
 (2603:10b6:a03:452::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.4; Tue, 30 Jan
 2024 22:05:21 +0000
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45]) by DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45%8]) with mapi id 15.20.7249.015; Tue, 30 Jan 2024
 22:05:21 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Shradha Gupta <shradhagupta@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Topic: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Index: AQHaU0yZNOZ7/lEXVUScWvjgIg8G/LDyyvGAgAAY7WA=
Date: Tue, 30 Jan 2024 22:05:21 +0000
Message-ID:
 <DS1PEPF00012A5F565EC849626E8F32EDB5CA7D2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
References:
 <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SA1PR21MB1335C5554F769454AAEDE1C8BF7D2@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB1335C5554F769454AAEDE1C8BF7D2@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=beac0a21-5dac-4c54-8eec-76ca3372c098;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-30T18:26:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PEPF00012A5F:EE_|SJ1PR21MB3722:EE_
x-ms-office365-filtering-correlation-id: 4ff498b9-fafb-49ee-8ca0-08dc21df8d9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2cNk8iw8lpQ4CFXeKnsU43WxdMFjfkFus9dk1IKjtfoJje/8YhqG53Ru+P80RcJGuN3tJdYORWNcyyvDuc49B38MfUcd9PLWcCW0LqnAC1uEZ4gwLjNEdhvm6JxqvDDkuOwRnDgHSJPhtEJvgoD0diTKwRV5mfRM0bapf0Y1GxgRLevJK4CTJWJ+dDOkUF9j6YbaueOqHpd54vfL7UBE0FFLQebHo5qLIGG1+MhCYL+KmZaQ68F7DPxYoQvIEJ01Tl4RVs15m8WVa8ytnM45Ia6kbOPSolOH7fV4GVqb3qjP3mzytYJ+EjOa/ra/DmKDbSXMnVoIo7CDi1hZ0fXOQpjglvUElYF6RSlcibAsjmDu1brm8uVddoNswPn+9X1BHXjIzm7jdZk5tG25/7pnZfFKYAVe9FYKKUO8ZVytBcEnTWmp8cLih0srV5iI+2nC130IBCgENYvEo6Ds7cE+sRsfQybg6AWWhmDdXUlZwHqFztMlfh3KprD4YP2ju+3YbFzcWe15ayDxX26UF0YpGIIvjUev+QahJVz/eU3AK+ZTG9+GuPEm330pWVD8bejfMxcaYM1aesfw+jX8HsUHtIRrNhXi50FNAw4dxxNjn/XlQivku7s4qnL0uX2Wv4vVrt0oAkXQ8NXLwil+nJmwlg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PEPF00012A5F.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(83380400001)(921011)(38070700009)(33656002)(82960400001)(82950400001)(8990500004)(86362001)(26005)(66476007)(122000001)(10290500003)(316002)(7416002)(5660300002)(66556008)(66446008)(9686003)(38100700002)(8676002)(7696005)(4326008)(110136005)(6506007)(71200400001)(52536014)(478600001)(2906002)(64756008)(8936002)(66946007)(76116006)(41300700001)(54906003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vHsQ49v01ZYz+3HsnkAgLmuHPGpaZPJFuFZ46VL4sNzHlHQ3fzaHFKSO0oA2?=
 =?us-ascii?Q?ek/P+eLq0r1MIX663sUrFSFmNF2fZ4rbID6dwoUa95/ZnNsTLTIT4HFZb1HP?=
 =?us-ascii?Q?ZTKdAiuKawmuPFBoKqwPGjjHrXqD29cejKAbRKhco/aK9CNkYH1lRgFVDBZj?=
 =?us-ascii?Q?n+SFIT5CupH7gsvKgoyAkPyNU1ZXw2ueQgxkLmX460ze9jnXTmAx61aUYEy1?=
 =?us-ascii?Q?4C1/OwUpAvdY7nNmxJzOVcmQixRqfqJONIx7xZd6pgmY28Jpf4HPuv+ZVS7z?=
 =?us-ascii?Q?Z+8W27c92br/WH2m7DsrpZyGGE4iTAmZ95TF1rz9IOInCG4+NJRb2cfVbiYc?=
 =?us-ascii?Q?HFq4ti+HY2xxdMcmZlKfGC3mhQti4Robf4SIb/sWW//tlJdLez5cH349hKsp?=
 =?us-ascii?Q?yJwmdhHh+9mTvyjFErANVXiZ4IluKhsO21OlC1Z5jFXK4BMz3GdYLwhPwnNs?=
 =?us-ascii?Q?O4gP8jSLfVKtb2MtxUZmMlygdC5MRsz2Df7GBGhkf29zq9Rp3YkzQSMgG91P?=
 =?us-ascii?Q?DgFrfHzYEsv8XnLHrfFFEdg7QLb+WouiMO2kOAaxgZxW8QASuL5cOVnnXudJ?=
 =?us-ascii?Q?vfIJyb05+x/40NmhYO0jRMeqsDNdUcX0zrQErQuIZk8WRo1ExlqXwS6Re9Ln?=
 =?us-ascii?Q?uYNzkOUa0GULNKupT+0letNyvHKIEtPAYG2q4Enag4HbmqKFFIXfA+skma68?=
 =?us-ascii?Q?1Q0GZgnsM6HFwm2p6f8WA99+gky0hvMcZ5yzCfvVFIsWrl7jfDZeDnO/9jJv?=
 =?us-ascii?Q?cvXBkpUl0mOVNEazvyCNI3+6bshtPSgnqTUxSmLqgpxwUmmYYitf0Hp8bSnR?=
 =?us-ascii?Q?8Qjv7mbPjNUwwKbAcqTjDdF47cmJX2l5ALHjZUAt4Phm0VIVNURLNrlOL9Up?=
 =?us-ascii?Q?xdva2WuO6+MiXjX6aqRHJxwPlD1vxq662G5pWvKNXxghOXYZN1iLwKUT3RgC?=
 =?us-ascii?Q?Q8EvoTbSjunEZ0UKwKUZG9psW61gG1AIzWssZiF+5F9kAubF9Ij1Tuins7VD?=
 =?us-ascii?Q?0T8S27cFKDuRclS+WwZJh4okjIfXV4pPpMGDdlIzXcoL+NgQzt01lDlhnyNs?=
 =?us-ascii?Q?Zk2wdbghRf008JOVOQwRYNhIfVDAUMEZCZp3OfYI44ZFCBi5rwyGxSdKa81t?=
 =?us-ascii?Q?IvBvf5K5PF93Gh2JJjnYyWYfxYCWNqcO1DeoaQwMAeuMm/Jsw0IAInzgO//9?=
 =?us-ascii?Q?Pw/Q+7FZrEwhH79xyJw9f6nkKnE5bAhGGauqh4zv/ActZ6xPD853uAHrRXZv?=
 =?us-ascii?Q?CsY4fX68vmJbhzN/eELTVRQuURu6MPTCKLDGzhanphT0hk04/Wk7Sd3jG6t6?=
 =?us-ascii?Q?uYBl+DjK16oKfuOwyFCBfRvvkHKuLcOBuuxXyk0Xjn9Ruw4kIAj9K8+6T8T/?=
 =?us-ascii?Q?PMKi4pWlUYNF0+nZ78fDQxSNHj0VAo2PN00FlUI9sgistYHTZw6715PeHX5S?=
 =?us-ascii?Q?n68whMYZlV5ljhKWUkZQXw6YGcYbFDrBQH83VmtZgCJrKrikvTVwmNKTvgw6?=
 =?us-ascii?Q?f2T8cEUS1ES4bew42JwRhQPDZYsd4awjiFyXtMwbOpEd7wv3W2FKUZ7NXjVP?=
 =?us-ascii?Q?Kz6HI20vRcX3q15ZxjpHmfsBvjdVZKigvuBORqV/?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00012A5F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff498b9-fafb-49ee-8ca0-08dc21df8d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 22:05:21.6830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZUf124y/IDvdKhqc+Fyqf2lyYwfwZ/OSDe0BHCYe3HwXcpDEI87RjcxYrqpzLfEon/ZxotxisjyVGT6q2Xk5Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3722



> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Tuesday, January 30, 2024 3:13 PM
> To: Shradha Gupta <shradhagupta@linux.microsoft.com>; KY Srinivasan


>=20
> > @@ -2205,8 +2209,11 @@ static int netvsc_vf_join(struct net_device
> > *vf_netdev,
> >  			   ndev->name, ret);
> >  		goto upper_link_failed;
> >  	}
> > -
> > -	schedule_delayed_work(&ndev_ctx->vf_takeover,
> > VF_TAKEOVER_INT);
> > +	/* If this registration is called from probe context vf_takeover
> > +	 * is taken care of later in probe itself.
> I suspect "later in probe itself" is not accurate.
> If 'context' is VF_REG_IN_PROBE, I suppose what happens here is:
> after netvsc_probe() finishes, the netvsc interface becomes available,
> so the user space will ifup it, and netvsc_open() will UP the VF
> interface,
> and netvsc_netdev_event() is called for the VF with event =3D=3D
> NETDEV_POST_INIT (?) and NETDEV_CHANGE, and the data path is
> switched to the VF.

In register_netdevice(), NETDEV_POST_INIT is earlier than NETDEV_REGISTER.
This case: netvsc_open >> dev_open(vf) >> NETDEV_UP >>
 netvsc_vf_changed(event_dev, event);

>=20
> If my understanding is correct, I think in the case of 'context' =3D=3D
> VF_REG_IN_PROBE, I suspect the "Align MTU of VF with master"
> and the "sync address list from ndev to VF" in __netvsc_vf_setup() are
> omitted? If so, should this be fixed? e.g. Not sure if the below is an
> issue or not:
> 1) a VF is bound to a NetVSC interface, and a user sets the MTUs to 1024.
> 2) rmmod hv_netvsc
> 3) modprobe hv_netvsc
> 4) the netvsc interface uses MTU=3D1500 (the default), and the VF still
> uses 1024.

__netvsc_vf_setup() is skipped from the netvsc_register_vf >> netvsc_vf_joi=
n(),
but called from netvsc_probe(), so the VF mtu is sync-ed to 1500.
I verified mtu sync in test.

Thanks,
- Haiyang


