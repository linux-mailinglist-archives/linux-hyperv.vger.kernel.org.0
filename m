Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0706B661A
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Mar 2023 14:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjCLNIO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 12 Mar 2023 09:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCLNIN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 12 Mar 2023 09:08:13 -0400
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBF110AAD;
        Sun, 12 Mar 2023 06:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjPmnWqp5Y6aSNToNzHq8/i0GDRyzssVvls4PxYDo7jGgaAFP06sP0rp0aoXyNMIQl2oh6XxzVgAIKyr4MiF1zOh8aDJhNVtzFXCiCSz0B5V3PbwZbj8Ry9Yiee9Ik5kNthObCy1a/JnSbxfD4gfXuDoePLw5o+4/3DuWzKy5XScuKQb3al1LZjV0KmxfQIixm+UW/N4PASNuNQzMd68j2gRSS+lI4gmTIomLmb/aWmGokNHPC0WClEoCUc7hkpD2Mko2awPFyU5Pt2UE01GPy5mDDAiCubDzpThLDlDjJm/gMg+CrAptanaLVrl3d8A2Djs3tVZzQOQA89FTZhmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oPoIzOgjJYw4tbeySKfkJlZuOfToVlJeK55sh0ayUc=;
 b=OxSPoMYVZJT5UyD+ddaJmXJhCXlp9rTbYCvzzUuGoIGrP/ysH3hrgxAoTl3vn+xOwR9nQju+YiUzM5xAioccoFGl1YfFcNVRXFcORyHrHd+Z/9oJL/WgcDK/1M65dAYzLEeXYQTbHx9CsyrvKmiKa/zK2QpuUbAYvlLT5A1HcTiPvid4RtfsmUtgX9+CKXskkqmGEduW59Q/p9zxy3Sk0VYuWx+oE4pS2TLX6Gk/9Jy2caPXM2leI+/rcdqsEe3InAzGv9DGhh+oH6yy/CN+/ClGH22W6noSrSapuhdjMsgYmXntzODTTpDh7R/x80kjgSN7xmPU7BQileySSw8phw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oPoIzOgjJYw4tbeySKfkJlZuOfToVlJeK55sh0ayUc=;
 b=bSE29UQ1CUiHaLJ78TbOnlKIENG0aNZ7OidB5yXPUp595vgZ+Qks2eU6wz1BVl5FMb1UrCsoCsStYKJhcpY3pDlqpnfiT+mGSfWuZKHRIjdNxhhFslYg9yuzPM64TUYq8hFAmqA0khaU67Y/XOWmdgjjqxO9h4vMvxI33QZUmCw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY5PR21MB1476.namprd21.prod.outlook.com (2603:10b6:a03:21d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.3; Sun, 12 Mar
 2023 13:08:06 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%4]) with mapi id 15.20.6178.024; Sun, 12 Mar 2023
 13:08:03 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Thread-Index: AQHZR3oO8XCRAJVOTEyd9eleCYLxd67zCduAgACLQoCAA5rBkA==
Date:   Sun, 12 Mar 2023 13:08:02 +0000
Message-ID: <BYAPR21MB1688FD8EA30E876F22560645D7B89@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
 <1677151745-16521-6-git-send-email-ssengar@linux.microsoft.com>
 <ZApMqWPWgWXIju/g@liuwe-devbox-debian-v2>
 <20230310053451.GA9705@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230310053451.GA9705@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=31ca5762-7f8c-4f27-9ec5-e88eec527d92;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-12T12:37:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY5PR21MB1476:EE_
x-ms-office365-filtering-correlation-id: 7c8c48d2-d179-47f8-8081-08db22facffc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fV2AWllID0p6O8ukWXP000pbGoFarQ01K6XE5JEWTr8wRWS08AdYr6IaNuHofxJF6t8W1BrhU8m685ziZlQHqEW9ZKInuY8mcW7ccxItk4l7vmyTdI1GJDxLN7vSrm7m0OAAKHiw8tDYGk7sXLhzyquqez9SSdXMYS7aCOHZMe7vnilz+I1oMxmwTK5xVF4yiJ4dcviQPbnyjVLtxOJaaf46eRvbLisE8ikoqwu7VG5U/ciBACVB3wX7GT7301eaDe4knDq/BZoGfHIDzlnfh466ZY/JAUJRsjKeZaOBO+sHcSh9IrKW1N66JajUqY3aG62Ub/XAM+yrCWHJCv3OOF7rAQOYU+T18p2PYdhtOrsJkYouNmHJzd6xWMfr3gBu/7FTrm61tC074TSE+E2Z39et8uaQUtGuInStRIfet9xr3ywsJxUCC58aF8EhSWhEY8vsK4ZsTtC/c+gP5gmL/NQx+3PXI95ySGxQEwNs5iwcg/Ivy4/sEsLDlWn93S0e4paAVKFcrJkj0cOuX7rckKIE/bGj5JAHIPgj+fuTOb5eC/WGbCKXQfh1MTeb2SK5bdVflWgLMnv+y2U3PeDwAObJCJOl4uXKLQ9CtxCyy3XKaO8EC04lI8qgvSDM0Z+axfETdIkti5+kc0WbgInwdNsayq8+oGezSa+r0ysZ0W4VAtlldf3/AwYCvFJcqqUT2k3TBXhWkz3CwWyyG+nbGnKjJDSKBfEhTiAR10fq5YY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199018)(5660300002)(7416002)(41300700001)(8936002)(52536014)(55016003)(33656002)(86362001)(38070700005)(122000001)(2906002)(82950400001)(82960400001)(38100700002)(8990500004)(10290500003)(6506007)(9686003)(478600001)(83380400001)(7696005)(71200400001)(966005)(76116006)(8676002)(66946007)(4326008)(66556008)(66476007)(66446008)(64756008)(110136005)(54906003)(316002)(186003)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lXkBU93mrgR5bLCLc3B7PScXSCs8OgUzQD0h62lTduSq8h+SqqbyKltdKOTe?=
 =?us-ascii?Q?QxHZ4TtE6tsvsMTvHV/SDtFfsroVZ6xwELy0EuoQppT/J03N039Kw1z73iBh?=
 =?us-ascii?Q?rd6BS/Al8fN52COGQA88Ssq3PTT8Dkx6gGqgwKLKgGZLg6bBB0RnWbYXkLEp?=
 =?us-ascii?Q?SPrQbzJ2rPc9cb9yDYsJH8y23jPg2AGktd8GRTHiQHDerO9hsEHYL09rHFDj?=
 =?us-ascii?Q?o/Qg38ACx5R0xySMOlpPkla8pLvOyCAFr0RlgxFhbuhVPMyxuifmVrw+Uybi?=
 =?us-ascii?Q?AU5JJJUIHcCTCOLk4JJgpWhsW+6vJD0RIJquu8FZqKY5IoYJjyV2FoskqYEA?=
 =?us-ascii?Q?DvIKoTdzyNQ2EmRwd29+A72iD/A97j5ZYFEUR1aSIkHjGAkE98UKfewdlokb?=
 =?us-ascii?Q?DSmBPn+fmKSNkFvehUeeCXnhdPmc/UR0CN9Mj6OhWGS9l9GmHBJmuMS4fzS+?=
 =?us-ascii?Q?JUd9fjRc1qVnG/Xba0VymJDN+Nd+w0O5EYff6hovNuWBeyqFXC+xbE912wr1?=
 =?us-ascii?Q?tx9Bw1KQMjKNmy02rMocobbK+uDeboZnti21kyobZcf15y7NdGpru4NfR4HD?=
 =?us-ascii?Q?jQJErbl5RaWDUN39H9p6kPHOy8kWyDuyukFZEw5hcXRAENdLNPvKA2d90RqK?=
 =?us-ascii?Q?Bx3GzvRnthSbKwHL2i8tfpEhc4E13l/T0H1uPtQIf6F1VzHcj7Guty0wQuR+?=
 =?us-ascii?Q?Cd7HABfNd0G16wTyUf7zrROt+HRtLpYTy4QBcljn4u02DURviUdNgV1gA6+5?=
 =?us-ascii?Q?LPBpplbwEgrYwB4LtPevSAQK4BuIn3lZHpDeVQ8vvzH835msMzEfqJRKFfrs?=
 =?us-ascii?Q?RrBGO4a3LvurxCeUp2WKf7fHLeJgzNucvDbGifYd/IzPNe12zHjNzg/dhIdc?=
 =?us-ascii?Q?Kya38WIHwwzvCXyGEfcvTz4ooJnMqZiB5l13MGKKB21lPpfZKky9by2nk5sU?=
 =?us-ascii?Q?+4tSGk+kvlaLleHWAp3uCoayAJvSjx+5ZSZVbbyJ0QovEqgJcCvIxtDUDjUG?=
 =?us-ascii?Q?/S/layKey+r4AEceFZdgwGnL9Et6tRg+DB+VUVIjnRZ/fzHGg14tB0rMk/Ag?=
 =?us-ascii?Q?FZKSVlRKgu/1ItYq/5NzeDRhU9M5rgCsLF7PILE7M7pZd7aevDoH5+ZcuwBD?=
 =?us-ascii?Q?bHxiqg8SfZckMloBTFS1ajvWdIZMPxA3QTSmd3h9OgO1fLWvH0RkIQhFIpMR?=
 =?us-ascii?Q?t6/nA7CY5anm1nNaAn4QO+oPbjH7FvTiR13BKtiNVIqRo2iKyNGSJQVJQ6Lz?=
 =?us-ascii?Q?e2spr8edW/tccsEmchOEzk+ay4a5JPGgTLQiNnDCZCSLEZCteD7H9avqYKD0?=
 =?us-ascii?Q?RWBkIsPueQ5usW6IUWKEDPfI2Wf2KRqgzg4wJb4/YbIZypxlGJj81rCjVflS?=
 =?us-ascii?Q?Hk7XkHh1/ljyzfNhsKe+gkRNm7mqU7B2LpzVnrPOCINYzbxm0zK9RASodYkx?=
 =?us-ascii?Q?vR/AFReSWK03cVAGaG66GJkUIsSWfyuaj3EfNEDO67FjhRuyMCoQlj3y+7K+?=
 =?us-ascii?Q?Z94tuoO4ouctj7rHgaFL/ybA+LvA2RY+Cqdt3kH2PwNWoYpv6nHG+iVqGpOL?=
 =?us-ascii?Q?mvmWgQL8BDgiJ9QbJ596iVgxS7QTjAdxDJljBNJ2XjsvU6aL0Rmo96CA/RLL?=
 =?us-ascii?Q?B2Dk5Dos5nYsG3CW6UZ1qp8qaYtFX/VLg3BtafKIqG09rB8t50jg5YwxbGyR?=
 =?us-ascii?Q?SHyDhw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8c48d2-d179-47f8-8081-08db22facffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2023 13:08:02.9032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIOEOJaB+v1GFsou7pbXi1X3N5bkyW2SQLtdZUx56CbfvyYlzgxsRpbpNl/UALzIobpXfJmZntmPMrQpvK18QwPaUyFJDNhM8Pe1qhJ0PQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1476
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, Ma=
rch 9, 2023 9:35 PM
>=20
> On Thu, Mar 09, 2023 at 09:16:25PM +0000, Wei Liu wrote:
> > On Thu, Feb 23, 2023 at 03:29:05AM -0800, Saurabh Sengar wrote:

[snip]

> > >
> > >  static int vmbus_platform_driver_probe(struct platform_device *pdev)
> > >  {
> > > +#ifdef CONFIG_ACPI
> > >  	return vmbus_acpi_add(pdev);
> > > +#endif
> >
> > Please use #else here.
> >
> > > +	return vmbus_device_add(pdev);
> >
> > Is there going to be a configuration that ACPI and OF are available at
> > the same time? I don't see they are marked as mutually exclusive in the
> > proposed KConfig.
>=20
> Initially, the device tree functions was included in "#else" section afte=
r
> the "#ifdef CONFIG_ACPI" section. However, it was subsequently removed to
> increase the coverage for CI builds.
>=20
> Ref: https://lkml.org/lkml/2023/2/7/910
>=20

I think the point here is that it is possible (and even likely on ARM64?) t=
o
build a kernel where CONFIG_ACPI and CONFIG_OF are both "Y".   So the
code for ACPI and OF is compiled and present in the kernel image.  However,
for a particular Linux boot on a particular hardware or virtual platform,
only one of the two will be enabled.   I specifically mention a particular =
Linux
kernel boot because there's a kernel boot line option that can force disabl=
ing
ACPI.  Ideally, the VMBus code should work if both CONFIG_ACPI and
CONFIG_OF are enabled in the kernel image, and it would determine at
runtime which to use. This approach meets the goals Rob spells out.

There's an exported global variable "acpi_disabled" that is set correctly
depending on CONFIG_ACPI and the kernel boot line option (and perhaps if
ACPI is not detected at runtime during boot -- I didn't check all the detai=
ls).
So the above could be written as:

	if (!acpi_disabled)
		return vmbus_acpi_add(pdev);=20
	else
		return vmbus_device_add(pdev);

This avoids the weird "two return statements in a row" while preferring
ACPI over OF if ACPI is enabled for a particular boot of Linux.

I'm not sure if you'll need a stub for vmbus_acpi_add() when CONFIG_ACPI=3D=
n.
In that case, acpi_disabled is #defined to be 1, so the compiler should jus=
t
drop the call to vmbus_acpi_add() entirely and no stub will be needed.  But
you'll need to confirm.

Also just confirming, it looks like vmbus_device_add() compiles correctly i=
f
CONFIG_OF=3Dn.  There are enough stubs in places so that you don't need an
#ifdef CONFIG_OF around vmbus_device_add() like is needed for
vmbus_acpi_add().

> > >
> > > +static const __maybe_unused struct of_device_id vmbus_of_match[] =3D=
 {
> > > +	{
> > > +		.compatible =3D "microsoft,vmbus",
> > > +	},
> > > +	{
> > > +		/* sentinel */
> > > +	},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, vmbus_of_match);
> > > +
> > > +#ifdef CONFIG_ACPI
> > >  static const struct acpi_device_id vmbus_acpi_device_ids[] =3D {
> > >  	{"VMBUS", 0},
> > >  	{"VMBus", 0},
> > >  	{"", 0},
> > >  };
> > >  MODULE_DEVICE_TABLE(acpi, vmbus_acpi_device_ids);
> > > +#endif

Couldn't the bracketing #ifdef be dropped and add __maybe_unused, just
as you've done with vmbus_of_match?   ACPI_PTR() is defined to return NULL
if CONFIG_ACPI=3Dn, just like with of_match_ptr() and CONFIG_OF.

> > >
> > >  /*
> > >   * Note: we must use the "no_irq" ops, otherwise hibernation can not=
 work with
> > > @@ -2677,6 +2729,7 @@ static struct platform_driver vmbus_platform_dr=
iver =3D {
> > >  	.driver =3D {
> > >  		.name =3D "vmbus",
> > >  		.acpi_match_table =3D ACPI_PTR(vmbus_acpi_device_ids),
> > > +		.of_match_table =3D of_match_ptr(vmbus_of_match),
> > >  		.pm =3D &vmbus_bus_pm,
> > >  		.probe_type =3D PROBE_FORCE_SYNCHRONOUS,
> > >  	}
> > > --
> > > 2.34.1
> > >
