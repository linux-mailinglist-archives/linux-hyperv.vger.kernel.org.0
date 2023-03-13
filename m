Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8639A6B6D72
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Mar 2023 03:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCMC1S (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 12 Mar 2023 22:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMC1R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 12 Mar 2023 22:27:17 -0400
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCAD32E7F;
        Sun, 12 Mar 2023 19:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odficeVcCk3hsRrjAfATAg0T5xi3Cp3iboaaU57A4H3HcRn8SwQJnQLVAEOCgqWZi0CFSQfUO4xuO5Sb81W5DpOhbiVYn1RMBZPX9aaJZRIfjeIKQeFi7YLyfaQQs/oy16YSz89VL56oxgzbOd4pd8wuEIthgFPeGCtliQ6boIwXigTDq6AuKw4Qi4u4wSMBA6JYMJgGeayWRx2sdO6q9oZSjnlSxGFh6HGXBzpgVk5waKJ+2w7dzyjKFxLedLlD/BzPbgsZW24No4si32XUIkl6dYGnhFa8YSpwdvj/XGUEwhYTPOsJ/ggoAO851QJVAzBRe7OURwPlhfL0z8dUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ9ge41e0Oq8qDFrPHjAxTUhm8p15N1eUxEgstuT0l0=;
 b=B2CKZ7DJ8xUPQdQVjMXDmQhtrue8a5lMrziCOyaphqC1cOgZvNl4oIBxHtXZ+Lb2Iey193OfLC+NqmoBQQ69KiTeV4fZhWi7UsxL2gKbDYbGMxly/VAEnlyReXgaLWbT2ya/qrl2WrFn282eQrYqh2WVH0lele3glLgkOZWA/MuU23ESJ8cYi6OR3NiKZPBztmgNKItx7wzA+Vu3Wz5BeNoHqf3xpjaIfSI4nC54ZG7jaOvImpMDKuK11K1sBZjO4MNtFYo+6f6YGowOXJbsjEkkQkoS/Pl1cCaIiTp6vabcSvdQtuksIIErHWfqW+LGFOh92k3g+C2j4f/4+kWAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ9ge41e0Oq8qDFrPHjAxTUhm8p15N1eUxEgstuT0l0=;
 b=AGEb6wZlKR1Tie89fZEYRVCV9DxIeEobLSiZDKLF7ojSoaWYThIYDOYHr99E2fdaUN02O3rq1ArGRFzpHWn36luSoiA0polMIgBvbuKEHPpXlpYjoD1h9ft+vIk7w6C5vFFg+TGQvuSVyZ8Ow9en8r+lcGyBrIge77bSZR8/nAA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3139.namprd21.prod.outlook.com (2603:10b6:208:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Mon, 13 Mar
 2023 02:27:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 02:27:09 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC:     Wei Liu <wei.liu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v7 5/5] Driver: VMBus: Add Devicetree support
Thread-Topic: [PATCH v7 5/5] Driver: VMBus: Add Devicetree support
Thread-Index: AQHZR3oO8XCRAJVOTEyd9eleCYLxd67zCduAgACLQoCAA5rBkIAAVGUAgACR8BA=
Date:   Mon, 13 Mar 2023 02:27:09 +0000
Message-ID: <BYAPR21MB16880CC7D849D59FF33611DCD7B99@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
 <1677151745-16521-6-git-send-email-ssengar@linux.microsoft.com>
 <ZApMqWPWgWXIju/g@liuwe-devbox-debian-v2>
 <20230310053451.GA9705@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <BYAPR21MB1688FD8EA30E876F22560645D7B89@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230312173934.GA32212@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230312173934.GA32212@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=02bc9be9-d3b5-4d87-9b5e-02f85c58bb93;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-13T02:21:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3139:EE_
x-ms-office365-filtering-correlation-id: d9aa0e5a-7820-4e5f-0f56-08db236a7244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aWwJGoeHBFh9k5CDJKBtKQR0aP3yZzFjUPqCUHzn98yeZWSucG2LS595eQBLrsZwuwLpd15MUiRFkmKQ3nnDB8HZ3Dt72yzPPBir52hYnCmfne7LeWNfefhxTplLjp4Tyx+iVgS9ndqSrBU3Vppy7HiMkdtr85PIpiRt4ijyLgZjcFbXsBVjcWpgHoV0geUG5V5UbWWDXOXs2vrDOpq6uhdmhJQ+9uCGb/rBxksUDOoAQiMVL2ejzS4inr3hkQ8YWiRFh2UKfykB4Ty/2HlIpR0T9vtl6xUaM1UlVdjUqRJ1bnOE3B655JF+AN9JJ1dhlogXxVwW1KJt9ybNYLX9vmsLlc9Ec+2y0O9bjqDFCFvXuNbpQAd4qI+7vZrcMmgYKX+n6cx9VZIIXck9TdspNaSmVd3ccIaxLmFeqxh0ECcImsyROqaZ4Z0H/uUTLa/TF7Ai7fMkS8tva2AoJtaPdRGEdrd0vaMHk8brvz4X9Ne8+tS6D646eXpnl5tCWHUMaERXtVJXvapcYHCKCMjY1HDsdkc6ArWp0Yn7xyyhOVzJf2IdH0HTuQWKCZPZRUxk4BXRKC8SP6HRLF9XpVd/uQxYp+9oKqLbG2kp9G3QntcFQOGnMECaPtrr0CSdFgDVJQn616r7wadgWd83LUJTtLmBPoZ6j74oIAZuIJflDVO1lnI0W7Kgzi1lA6PkQZrC/buDO38Nfh1Ibq814V34T0TA6dYQvn0Zw1tuc1bQO98=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(8936002)(6862004)(7416002)(5660300002)(41300700001)(4326008)(52536014)(55016003)(33656002)(86362001)(38070700005)(122000001)(38100700002)(82960400001)(82950400001)(2906002)(8990500004)(966005)(83380400001)(10290500003)(478600001)(71200400001)(186003)(7696005)(9686003)(26005)(6506007)(54906003)(76116006)(66899018)(316002)(66946007)(66556008)(8676002)(66446008)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7JumcUSoK24fPD+gsg1QpF3KGQzvDRBcRQKH6HIffNB+7xcpHugpM37tcTKf?=
 =?us-ascii?Q?meas0wf5aBEleYW/vSuEPfo97suU8CLdcHAduaW6dL0Q5Vk+KnLnVpgK8+TL?=
 =?us-ascii?Q?X1ASQr6aqM/eedzcTr5SAcyHffAorz8JR7rkblK74z9f6TH086HnTUYglGhe?=
 =?us-ascii?Q?o/d7nabepDqrWZIV/RL8lv2PvD2SQVyKFtxteHEfz4nvnVVpNk71GvnR0kh9?=
 =?us-ascii?Q?ycHiluHYSG+SIz9AYmvF63CY6Lbj+OxIyAp/85Dbrnn8FfVYcqCkt+ulfyQE?=
 =?us-ascii?Q?LFqyjtzhKuh0wXiXtCFR1/wYvPpJZ3xCR+cODTt0JgOZ0sUFinpdIwnth+oJ?=
 =?us-ascii?Q?iBf7hbpxmpfrmJjyNeiBpuEbg3whbx7DrWVptuSf/MONGR/oWfpI7+H+ufqO?=
 =?us-ascii?Q?xROvnIhj/+3wQlgSm6yN7W2xcLXmQNJ3v26VMnuka384/Db1SHF4IXrXYeJj?=
 =?us-ascii?Q?IqV0b+o+W+kWbG4MjG82akNqWf1Cean2r63o2QoT/L9Hbmckj4PYV6g/Y66V?=
 =?us-ascii?Q?yhkRbJYioH+FVSj4rnma6A4pwLCg1gCZPIKFynNcDrOcoJpESd0LFmN7AycH?=
 =?us-ascii?Q?BzFnkRpehPSFFBXyJWmtF4169a0qV83OSIG9Ow0UTtU6FKwwunwTjLroFJ3P?=
 =?us-ascii?Q?S6n31util0wnsOt4uWy6gu820uJUr/HUlHj9bzcHaGWS9eG8auQZ5qtRReuE?=
 =?us-ascii?Q?x478ZgzP3bzbh7XyesXLQ9DkFl2VsCqsPii6152Up/er/a4XMxWfM5IWGWdB?=
 =?us-ascii?Q?iXdPUBIDeeyfuTuLJg/ij1xQJ0zSthPdUMwyDgaCOy9gDVo4Bq7EREyQ8T93?=
 =?us-ascii?Q?F+aDOvd1JJDtPxunAKcqdhhuPswjspnn9EiZLm+twIJ5/kOr+8eCjUoY55Ha?=
 =?us-ascii?Q?9qp0nJWXM4/papteh0pLTEfVHS6ajCOTE2pLY9v/htygmW9zHf3718jurWPv?=
 =?us-ascii?Q?Bl+KJ01vqAUuOxKk/y3SRl+M133XH8mLRhPfDJvDEUqaZqwdsZS0i6keAvso?=
 =?us-ascii?Q?U1zwHd3tsayiB2NpvG5Y2id6JDBdoILVa1jCTRZ8TszARAVRp6SlatysTMh7?=
 =?us-ascii?Q?yn9cmZo96dg96PToGphbVNuKLvppHYpmlqFTBdUQ0TYx5VypyZMyHcmSTh0x?=
 =?us-ascii?Q?ZaSeTjUsOeGUYvryf73WEa7UCPqjAOeMTVYQ9GDrSytS2a4J6rA90djxp8mT?=
 =?us-ascii?Q?gDjcMx9w/CNSIXbNyvq0OL8NJARmorRg+LbAb058dft1xapmrsH9piMbLVOp?=
 =?us-ascii?Q?gihn3/XZTEM/1w80bR6jMIV28vkO8QfDnhMRdZG6qguch5T4miwCgbS9Hmcr?=
 =?us-ascii?Q?oC0iSjtblKuMJEsGSNq2MLWC21PxcX6cXur7rHzWvHGHxupgBRzlnz6p92wE?=
 =?us-ascii?Q?cvr0wkqECKODetlH16iKYX3GSAhoRspEKJFINmFtia1UC2OixSI1CedMopR1?=
 =?us-ascii?Q?BYv0b5Tx1lYPStq0eG/PojYI2Tuqw0Bkt5Za4Yw59WH4QbpqahPAZafvQ8lV?=
 =?us-ascii?Q?v7Nl/N5mQ+njVoB0+u19+vVyeZ+VKQIvoH5uLynvVR2F4yrwX1Hqdw4KvHgV?=
 =?us-ascii?Q?tvbzjGrh39be7f2RmpMmUPuoE4SKeMNs6boeRDFJP35wOyZL+EUi8KEyZe1B?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9aa0e5a-7820-4e5f-0f56-08db236a7244
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 02:27:09.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67x2aOxfSy47X2M7BljbNcQoOKwNwyWi3gPM8qDv/5UhHz0Tm/WxIWg7cAm5VKz22HE3aCUpxtXuxGjbD+a+i4gn57L0DTHwaLAwOhn388w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Sunday, Marc=
h 12, 2023 10:40 AM
>=20
> On Sun, Mar 12, 2023 at 01:08:02PM +0000, Michael Kelley (LINUX) wrote:
> > From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Thursday=
, March 9,
> 2023 9:35 PM
> > >
> > > On Thu, Mar 09, 2023 at 09:16:25PM +0000, Wei Liu wrote:
> > > > On Thu, Feb 23, 2023 at 03:29:05AM -0800, Saurabh Sengar wrote:
> >
> > [snip]
> >
> > > > >
> > > > >  static int vmbus_platform_driver_probe(struct platform_device *p=
dev)
> > > > >  {
> > > > > +#ifdef CONFIG_ACPI
> > > > >  	return vmbus_acpi_add(pdev);
> > > > > +#endif
> > > >
> > > > Please use #else here.
> > > >
> > > > > +	return vmbus_device_add(pdev);
> > > >
> > > > Is there going to be a configuration that ACPI and OF are available=
 at
> > > > the same time? I don't see they are marked as mutually exclusive in=
 the
> > > > proposed KConfig.
> > >
> > > Initially, the device tree functions was included in "#else" section =
after
> > > the "#ifdef CONFIG_ACPI" section. However, it was subsequently remove=
d to
> > > increase the coverage for CI builds.
> > >
> > > Ref: https://lkml.org/lkml/2023/2/7/910
> > >
> >
> > I think the point here is that it is possible (and even likely on ARM64=
?) to
> > build a kernel where CONFIG_ACPI and CONFIG_OF are both "Y".   So the
> > code for ACPI and OF is compiled and present in the kernel image.  Howe=
ver,
> > for a particular Linux boot on a particular hardware or virtual platfor=
m,
> > only one of the two will be enabled.   I specifically mention a particu=
lar Linux
> > kernel boot because there's a kernel boot line option that can force di=
sabling
> > ACPI.  Ideally, the VMBus code should work if both CONFIG_ACPI and
> > CONFIG_OF are enabled in the kernel image, and it would determine at
> > runtime which to use. This approach meets the goals Rob spells out.
> >
> > There's an exported global variable "acpi_disabled" that is set correct=
ly
> > depending on CONFIG_ACPI and the kernel boot line option (and perhaps i=
f
> > ACPI is not detected at runtime during boot -- I didn't check all the d=
etails).
> > So the above could be written as:
> >
> > 	if (!acpi_disabled)
> > 		return vmbus_acpi_add(pdev);
> > 	else
> > 		return vmbus_device_add(pdev);
> >
> > This avoids the weird "two return statements in a row" while preferring
> > ACPI over OF if ACPI is enabled for a particular boot of Linux.
> >
> > I'm not sure if you'll need a stub for vmbus_acpi_add() when CONFIG_ACP=
I=3Dn.
> > In that case, acpi_disabled is #defined to be 1, so the compiler should=
 just
> > drop the call to vmbus_acpi_add() entirely and no stub will be needed. =
 But
> > you'll need to confirm.
>=20
> Thanks for suggesting acpi_disabled, definitely this looks better. Howeve=
r,
> we need a dummy stub for vmbus_acpi_add in case of CONFIG_ACPI=3Dn, as co=
mpiler
> doesn't take out vmbus_acpi_add reference completely for CONFIG_ACPI=3Dn.

Fair enough.  I wasn't sure ....

>=20
> >
> > Also just confirming, it looks like vmbus_device_add() compiles correct=
ly if
> > CONFIG_OF=3Dn.  There are enough stubs in places so that you don't need=
 an
> > #ifdef CONFIG_OF around vmbus_device_add() like is needed for
> > vmbus_acpi_add().
>=20
> Yes, I tested this scenario.
>=20
> >
> > > > >
> > > > > +static const __maybe_unused struct of_device_id vmbus_of_match[]=
 =3D {
> > > > > +	{
> > > > > +		.compatible =3D "microsoft,vmbus",
> > > > > +	},
> > > > > +	{
> > > > > +		/* sentinel */
> > > > > +	},
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, vmbus_of_match);
> > > > > +
> > > > > +#ifdef CONFIG_ACPI
> > > > >  static const struct acpi_device_id vmbus_acpi_device_ids[] =3D {
> > > > >  	{"VMBUS", 0},
> > > > >  	{"VMBus", 0},
> > > > >  	{"", 0},
> > > > >  };
> > > > >  MODULE_DEVICE_TABLE(acpi, vmbus_acpi_device_ids);
> > > > > +#endif
> >
> > Couldn't the bracketing #ifdef be dropped and add __maybe_unused, just
> > as you've done with vmbus_of_match?   ACPI_PTR() is defined to return N=
ULL
> > if CONFIG_ACPI=3Dn, just like with of_match_ptr() and CONFIG_OF.
>=20
> I kept #ifdef so that all the acpi code is treated equally. However, I am
> fine to use __maybe_unused, will fix this in next version.

OK, I see your point about a different consistency, so this could go either=
 way. :-)
I tend to prefer getting rid of #ifdef's whenever possible.  Since there's =
a valid
argument either way, let's prefer the approach that eliminates the #ifdef.

Michael=20

>=20
> Regards,
> Saurabh
>=20
> >
> > > > >
> > > > >  /*
> > > > >   * Note: we must use the "no_irq" ops, otherwise hibernation can=
 not work with
> > > > > @@ -2677,6 +2729,7 @@ static struct platform_driver vmbus_platfor=
m_driver =3D {
> > > > >  	.driver =3D {
> > > > >  		.name =3D "vmbus",
> > > > >  		.acpi_match_table =3D ACPI_PTR(vmbus_acpi_device_ids),
> > > > > +		.of_match_table =3D of_match_ptr(vmbus_of_match),
> > > > >  		.pm =3D &vmbus_bus_pm,
> > > > >  		.probe_type =3D PROBE_FORCE_SYNCHRONOUS,
> > > > >  	}
> > > > > --
> > > > > 2.34.1
> > > > >
