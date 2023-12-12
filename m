Return-Path: <linux-hyperv+bounces-1322-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F180F44C
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 18:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682FAB20B61
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 17:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D357B3D8;
	Tue, 12 Dec 2023 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nm4erwdM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from HK2P15301CU002.outbound.protection.outlook.com (unknown [52.101.128.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B010E3;
	Tue, 12 Dec 2023 09:18:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ark1b/irkqKMz75lJ0OT1HFbvLdPkJunQ47u4H11yagNDNIonzYhY2dsoBTYNlNwySGvgIvoHUGMEX0Tk5N3M60Xy9tEBxPTYsN6vv5udbbiJo720+GemkkUGhNwzcaDcBEf1plB/K2OIrrbfkAAKIRm55kv/VaXo1IEKh0j5PJmmriOI9mBgiyhmRxjKLWv5Z3VKM27mcrj4Rwjl5gs5IWybev9dcI19oYFqxqlvmdLcvLzB6X24TawWkhXvsoN4pnnIJ9BZizu0WzStZrZGvNrR8wRge6Z4SMq8N1TnRUC80yIjWoOg42IgJCPg3MYsTPOrbArOEQVCAMGRgXeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmMUPoDrlHbFCFhvRhw7/azpHV3GvanZ8BAo8wVY+IA=;
 b=iXiRPjLXblA3XUJoDW7aGiSanpSLLWA0xRBywUSDadnW3MgLxt8EtMRKypEQGhAgAnRp7TGEipWouNwZ8/UvwA5tnZXDToyRYZ784XmcaBBt7KVd9Vsyr6QcCzbtZwUyPtartJDpXFz7voyi5GXLH6yIuCTPyh/bGk+2c+zE/13CGsVNPQtVeKmJd9VYvLz616PL5uRlZk3N81zMpE8Of33AxvaiEWvQAavtQOqpRv6XgNliDYHyfiRkzYISrPy3iidnipSWeBDDTMGuggKriI6Zfg8Uj3raIhurhWmv3qcQaEplO/m3Q8+wBmsb4vnO3RBJR19IeiOZidNxkwoDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmMUPoDrlHbFCFhvRhw7/azpHV3GvanZ8BAo8wVY+IA=;
 b=Nm4erwdMUcj2vMEpya91WFdHubhtstNTSxB4VHw00BwojwCzl74QdoPvKymqPqN6x8c6CwkVwhUckYRcEWl4JCMh4xb2YFMbmSuS2AdOUZa9f/9n+90HTYMXM9iQ19uw/GhF885Q7dj5i0K+mAMX2NqYyE8zGelW7aHJ4TQsPps=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by SI2P153MB0444.APCP153.PROD.OUTLOOK.COM (2603:1096:4:e9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.7; Tue, 12 Dec 2023 17:18:31 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a%7]) with mapi id 15.20.7113.001; Tue, 12 Dec 2023
 17:18:31 +0000
From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
To: Yury Norov <yury.norov@gmail.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "cai.huoqing@linux.dev"
	<cai.huoqing@linux.dev>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH V5 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Thread-Topic: [EXTERNAL] Re: [PATCH V5 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Thread-Index: AQHaLO/QR3tf0roc2kSw9A6kOF+FyrCl2CcAgAAJA9A=
Date: Tue, 12 Dec 2023 17:18:31 +0000
Message-ID:
 <PUZP153MB07885B197469B61D8907B1E3CC8EA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References:
 <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
 <20231211063726.GA4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZXcrHc5QGPTZtXKf@yury-ThinkPad>
 <20231212113856.GA17123@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZXiLetPnY5TlAQGY@yury-ThinkPad>
In-Reply-To: <ZXiLetPnY5TlAQGY@yury-ThinkPad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e7e8a57-51b3-47c4-96e2-b50e522ec308;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-12-12T17:06:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|SI2P153MB0444:EE_
x-ms-office365-filtering-correlation-id: 5c9c0f7f-4db8-43e2-fab7-08dbfb365d1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 X8XGRopp97LLKlMiCexzDy6e2laDytV2cmrQyh2El6g2psFD62dvGeLAO1VHRf81VbHmikdX9SWRg+I3OAXWxWehlShAUaWtPF9PXm+6im4y7z8fvmskm7BgVTo1V0Xrsx7WjDWbJfqmiNPHPQmhpq1NHzyoWJLZlsp1VzP/mRb5ITNkBBaT8lqw512NJKw3YyFMq6miiOtfB2mBfYJuAuCDs5CMQQpEnVoSnSIQQxGc00rledkmveNnxwLHDRBIWAobBzawRngSFkvufguoH4OshLbMiHPVHeYW8xTzeMq3YopIlLpdiJcC2NdpvrFLsYbQu4aDJtMJA5NttX6Tk+567M5CT+n+BV3ibu/PC4QXOGJ+acETdann1qqHRhSBCZGNG0Kj5kH9XuBbEPRlFYr6xJo82cain8nyQvsZTb6OhfUkxCjVap1+P+ubSxXb5oHVu6mLnctbL6tFfcTRX3hcqw9A+9X8KyC90yHE9uW6Lwmx3t5kU8jnF1Mnf0pv2cEUMX/XpUZamEFucx7lVhhVnjYbBUlvkSWbx9JLcNi61RtU4PhrD3mgmQTjODeZlTrOHHiM4diK1/EC1nFfswI7NpgLoOXwGcP6ZFdB/hljl3r5baoMy69GkKZ5q9c/mprYGiRGN3D1n722lMNJIlG6zX1uhUmV93CLxjdcEGZCPsi3nxT2K6ye62FHLwPXmjQ7a/u5wAIYxQIRa5En1Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(107886003)(83380400001)(38070700009)(86362001)(33656002)(82950400001)(82960400001)(122000001)(38100700002)(316002)(54906003)(64756008)(52536014)(8936002)(66446008)(8676002)(110136005)(66556008)(66946007)(76116006)(66476007)(55016003)(5660300002)(7416002)(4326008)(2906002)(71200400001)(41300700001)(26005)(478600001)(10290500003)(8990500004)(9686003)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yIKDYkhypvGUYjjc4ma8jyX7NeSTOESSu1Q6S4S7y0fpN73bMKMje8JJzGhQ?=
 =?us-ascii?Q?u+8GB2SApltw7nySJLRr2MZyapoBVyor37t/aHls288bOyskltoc39TYzNc7?=
 =?us-ascii?Q?rtDpC7gf//WFKDXHSG8jxb3lTzJtWNiw5ot7FGDhDPIk5NDZ5OegwQr7ghgS?=
 =?us-ascii?Q?jHSuiU1kjTYdKqIQG20JQvW4bDrhTMY/iSbHxWODeD3WDUKzK+psyXdcZLiD?=
 =?us-ascii?Q?IBoqExQw1/Bl0JKOoyeRrWtXVCPslgLTlKJbyyDRGt2AE/LWUptTKBjDa9xQ?=
 =?us-ascii?Q?pso4su7fY3YttlZ4G+XUpiAxfKakgPQldyIGtkVX+GGZdCN610s/woZD7q23?=
 =?us-ascii?Q?35QDfZ/OS305R6SM6hss5tk2QvExsKgWvrI1124edBWorNixLvOzmZTBu8xB?=
 =?us-ascii?Q?ism+yPAvMKJ8c4hMPHvBPD3ULsbILyPORgPTds8oJYipCsySSQ/eQPJVH4W1?=
 =?us-ascii?Q?eoWI3pbgw9i+4AR5sj2fjH8p4siM6132axr5V0ebK3BIiiXSqrPCNtrPEvSX?=
 =?us-ascii?Q?r9CEIUzGdhS1StdkE1LdpTs/pqFIprEeP6fGlO+kqoxqglQAriQP/yXiUVp/?=
 =?us-ascii?Q?FndS/gRnfaTPH07sQs0ejIVImVYQKdiRsTjQUN9RHEnr7WYiqMKcTX0jVU1l?=
 =?us-ascii?Q?Q7O2UihYFyVJI06OAt/L2jVM+sj3njubDQSZ5scqnO7kh7kn3SrLmgIPBWt1?=
 =?us-ascii?Q?e7JWztvPh/wNAysJD4RNjNE7Baft1KI9xadQ5P8nFiDeyYq3mVGfAjC1m//n?=
 =?us-ascii?Q?16bL7Rn31oECum2uVEct0ABbDeDsxvEZAXGP0AlOhbXI0IwHyv0fgb2u1BFR?=
 =?us-ascii?Q?h3C9DNr7TysPmIpJdgO/T1tDHuRvd7rRDl8Q/FakZLya4DH+HnDiqx18cMl9?=
 =?us-ascii?Q?9DxNKx3bEIRgRpZE+ivY13VOMwpbz2h6RmD8VpKvQ8rz0WJPS+QSg/jKjSSx?=
 =?us-ascii?Q?g/lPEr4MoPOg0c2LndCV6Y6Do7hCQ4mdmMHuOaTsLj89GJHXnee5F1X5uZix?=
 =?us-ascii?Q?OhwxY3Mb1mkMslNThL8pAedHn0Y2A32phLXIcsQhDw3Y5htqTKwBsr3cIRK0?=
 =?us-ascii?Q?4Rxn+xKWMPVBf4r3nWwWoTH4E+Ak7Ts0bpq3xmQR2k0WefS/xawgxwYZ5a5G?=
 =?us-ascii?Q?vPPzXehGFLzujk3uPEPrMHj3kd65SUEuK/2Ufzkof2N6dp06zfCgVed26rwd?=
 =?us-ascii?Q?6Qsu+s9dN+BYDXs9txaBT9H7aiIIIMs0G794P3A2T4xUORSNg6hkSXFCQ1OW?=
 =?us-ascii?Q?Zyfrauh6vwv6UDDwtciSUQhLvt4Ys1GnTFkuExiCcWEdtDGdVwxhNQV56d+b?=
 =?us-ascii?Q?tTJXFUtfpjad7rTlXiaS+C7k9jwHyrw8HexjWOKRUje/Mqr7qNxBGv+Y10zy?=
 =?us-ascii?Q?KP6vWkgpz9T1Lg14iMf1v5cpTJgGMOtuWwTrLkH7WpcDzilP+SS4HE5R/gL7?=
 =?us-ascii?Q?39oi6Zhr5DBeg8608yC6I/cXRybZsrIfA+PJIGehlYr9TQ6nsBF7yQrG87jL?=
 =?us-ascii?Q?Ohnf8kTJfqSeB7hhhFzfRRdn/X0v8yHulcXa?=
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
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9c0f7f-4db8-43e2-fab7-08dbfb365d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 17:18:31.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8l5ElsoCt/TA/hRWhIZQUeVZy1szfoWMxYpxZKVRwumFuK0QNUlLVSPSSUNJjkd3mc8OgoAbpnUIyHFYExS66AM083YvCB6CohD9AygGp70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0444



>-----Original Message-----
>From: Yury Norov <yury.norov@gmail.com>
>Sent: Tuesday, December 12, 2023 10:04 PM
>To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
>kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>;
>leon@kernel.org; cai.huoqing@linux.dev; ssengar@linux.microsoft.com;
>vkuznets@redhat.com; tglx@linutronix.de; linux-hyperv@vger.kernel.org;
>netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>rdma@vger.kernel.org; Souradeep Chakrabarti <schakrabarti@microsoft.com>;
>Paul Rosswurm <paulros@microsoft.com>
>Subject: [EXTERNAL] Re: [PATCH V5 net-next] net: mana: Assigning IRQ affin=
ity on
>HT cores
>
>[Some people who received this message don't often get email from
>yury.norov@gmail.com. Learn why this is important at
>https://aka.ms/LearnAboutSenderIdentification ]
>
>> > > > > +     rcu_read_lock();
>> > > > > +     for_each_numa_hop_mask(next, next_node) {
>> > > > > +             cpumask_andnot(curr, next, prev);
>> > > > > +             for (w =3D cpumask_weight(curr), cnt =3D 0; cnt < =
w; ) {
>> > > > > +                     cpumask_copy(cpus, curr);
>> > > > > +                     for_each_cpu(cpu, cpus) {
>> > > > > +                             irq_set_affinity_and_hint(irqs[i],
>topology_sibling_cpumask(cpu));
>> > > > > +                             if (++i =3D=3D nvec)
>> > > > > +                                     goto done;
>> > > >
>> > > > Think what if you're passed with irq_setup(NULL, 0, 0).
>> > > > That's why I suggested to place this check at the beginning.
>> > > >
>> > > irq_setup() is a helper function for mana_gd_setup_irqs(), which
>> > > already takes care of no NULL pointer for irqs, and 0 number of inte=
rrupts can
>not be passed.
>> > >
>> > > nvec =3D pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX); if
>> > > (nvec < 0)
>> > >   return nvec;
>> >
>> > I know that. But still it's a bug. The common convention is that if
>> > a 0-length array is passed to a function, it should not dereference
>> > the pointer.
>> >
>> I will add one if check in the begining of irq_setup() to verify the
>> pointer and the nvec number.
>
>Yes you can, but what for? This is an error anyways, and you don't care ab=
out early
>return. So instead of adding and bearing extra logic, I'd just swap 2 line=
s of existing
>code.
Problem with the code you had proposed is shown below:

> ./a.out
 i is 1
 i is 2
 i is 3
 i is 4
 i is 5
 i is 6
 i is 7
 i is 8
 i is 9
 i is 10
in done
lisatest ~
> cat test3.c
#include<stdio.h>

main() {
        int i =3D 0, cur, nvec =3D 10;
        for (cur =3D 0; cur < 20; cur++) {
                if (i++ =3D=3D nvec)
                        goto done;
                printf(" i is %d\n", i);
        }
done:                                                                      =
                                                                           =
                                                                           =
                                                     =20
printf("in done\n");
}

So now it is because post increment operator in i++,
For that reason in the posposed code we will hit irqs[nvec], which may caus=
e crash, as size of
irqs is nvec.

Now if we preincrement, then we will loop correctly, but nvec =3D=3D 0 chec=
k will not happen.

Like here with preincrement in above code we are not hitting (i =3D=3D nvec=
) .
> ./a.out
 i is 1
 i is 2
 i is 3
 i is 4
 i is 5
 i is 6
 i is 7
 i is 8
 i is 9
in done

So with preincrement if we want the check for nvec =3D=3D 0, we will need t=
he check with extra if condition
before the loop.

