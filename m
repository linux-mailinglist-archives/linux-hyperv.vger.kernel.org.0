Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971B56882CE
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Feb 2023 16:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjBBPjW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Feb 2023 10:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjBBPjQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Feb 2023 10:39:16 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A3342DF1;
        Thu,  2 Feb 2023 07:38:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edU8gyxn9jrapp7tif526GkWijYc8c9S3M21nFQCTMVR8WIHi9O+lhyYTTZVYYrv5RglTEPdU6KySrqgmYiFFLlAJZk9lIqCrlHn5ZwEUBccEQw1VyjT1udvX+nvsEEv7ppA88M7R/ThooC6HH5zyF6utS8zzFn7oD60SjqULsTTBYl6+uzfeOrx7GyxoI5ltKkJDoaeBrZ8wWZC6OIFQVC4Xs2IcM8GQsk6UMT8mlVG7rsnTYxwrQWAoijqnoDT1dwTWaRZVT3B64kml+VUHcNdXsQ5rzvQSmlWSbfcGGEYJfaXo851L/+tiuZwtH1m+PmLaFb96NEdGwd6esea8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yFwmGMG+dweQ30eHyhyamkDpZfRqps8zqMZ1tcNLBU=;
 b=eoSTgaIMyakkoOKGBmliKxHCIM2Ai5cMtIMp97N4Xp9xKnhTNJAsaZ15WecrPmtAQ494zkAdZPnJh7Ga4nEvq5Gz5SwdX8HJfRVyX8AI+StqzC7NDMDIRGcqIEAM8m02jjHJXSloLskDoxkbQG4e4aum5aG+3bLz+h42RQrjDqsRrKpECkUodH3dLNkn820zgZMroTQdtjsHbRY8MtNi84bY3aopJ1yH8m+Y22vM6eZuKeckI3So4Kwly7Atcv5jdWo/QbQaq0PIGaXC00GN0TRrbVhPpEThWQrKNA++afpYe6I3fdSHNWFzkflgbWbKarKcaCOa09KRPS52XDxZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yFwmGMG+dweQ30eHyhyamkDpZfRqps8zqMZ1tcNLBU=;
 b=i9R5AGI/Ta/nIK/OpkC21fdutkrroYdOd4m04vxOfxcwurLadkFWvSTaJjxFTxAE3dgGRjzaLgF652FfSyUnAZU5Sg9hRWTTCjLAYRRqUYF2BD4FSX5Q6jCPC/pv6zPYRLY2RgnPgHAci1BZxEQJpD+Q60KXbJG3dOXMz7OZR9k=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1992.namprd21.prod.outlook.com (2603:10b6:510:1f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.6; Thu, 2 Feb
 2023 15:33:13 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%7]) with mapi id 15.20.6086.007; Thu, 2 Feb 2023
 15:33:13 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH v2 2/6] Drivers: hv: allow non ACPI compilation for
 hv_is_hibernation_supported
Thread-Topic: [PATCH v2 2/6] Drivers: hv: allow non ACPI compilation for
 hv_is_hibernation_supported
Thread-Index: AQHZNZ9IFQFykaMu2kK/hQ0cFp0eSq66XU6AgAFiV4CAAAv2AA==
Date:   Thu, 2 Feb 2023 15:33:13 +0000
Message-ID: <BYAPR21MB1688C48CC77B43BC81B2E3E9D7D69@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-3-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB1688813B65EEDB79554E30D4D7D19@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230202144843.GA11173@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230202144843.GA11173@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=26de2dce-0d04-4a76-aa95-b16be2b3d53a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-02T15:31:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1992:EE_
x-ms-office365-filtering-correlation-id: edefa456-7c7a-49b9-bca5-08db0532cc2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y59kEgExVufJt94AdcBAjn1seMRmklet4FrRCB8EK1zSlb1s9vvtBEbwFzA+5FwTdYJn5IohMKGuGNTy5UFweAI+1LUYVk7r//TvA27MA14LtzMtjoMYq2y7dQUOvCp/JZpEWSoQU7U3aMo3iRNMamXWzz73Sj9H7ZU1X//SJ4U/ScfE6qYWVZ2OX72zlDCqHTfVJpX8WGrHpysWds/K7FC7Avul46LFpG4i2qy5kRmI2y1B7cG6tl8NeAOIB77G6dnjVkwklVlzpQCwCyUzNs4ApZWIL+SbBVAz+J0+Log1LdmxOiKCGVDpjtjcrQnt3Sng6C+TsoWEuaNROCbB3CsBenpppZ1/w+xTWg9F29h6u49yGShOeNERNdzJRLoaLdUs4dv2usYkQFvKQWMshWuvC7XzsVnM4zu24byGvZUp8lbjs9XfthDu48QA/Qz/NDIRJiQanLXH2UIo7Dz28+h6AFBYrqTplVGIxxfBcbu+O1ba/IKHC7l6suPXgfQQVXY7Yuq8fYDAUe8r09AcKokmhv8orKHYOdnJCJvcdx2LiI9DilWw55YH3mj5kH9648bY2MpTgeUDorhre7cpVMIjwFO7ynp0npaCnlKpCWwYafvaSY6Mzyh1hDmULUEDvCpZWWdglBcfDkdxj5T6n7rhXd28EifILyeggKiwfXVlMMx8eSqjDJLbk7V7DOnYE8R44vhfSN4h98l0Wiruzv7LPGfG5apY9CjXIPiXQ1y5G/FH5qBai9PIEg9FLlgt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199018)(38070700005)(38100700002)(55016003)(82950400001)(4326008)(64756008)(66446008)(66556008)(66476007)(66946007)(82960400001)(8676002)(7696005)(6862004)(76116006)(8936002)(5660300002)(86362001)(52536014)(41300700001)(107886003)(9686003)(6506007)(26005)(186003)(478600001)(316002)(10290500003)(54906003)(71200400001)(33656002)(122000001)(8990500004)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UbbQNW4pBTzwulFtJwA24JhgixbA4zme+tzwB3fDfJYn5ZkwqhS+gtatlDgE?=
 =?us-ascii?Q?lU2E0UNLLS9f9SZVPzvZu+9LT5UUj7VJqyfHBPLmBnTn9uiltE5pN5DzMf0O?=
 =?us-ascii?Q?lp3sn5qskBx0sWlGV0aCBWLrFjXA43WvxZs55+rimu/fQHWvF6hWGt3s4e77?=
 =?us-ascii?Q?WFarxSaN8JotIeZeU8FUK1SWliTvR0+fX58BXOy/rzV56I3OlSjiDljI+y/x?=
 =?us-ascii?Q?B8k3k/qbTCpUoD5RJIMbyEl3QYa1ceoOQCeuE3tieDp7TOEGKDWuUW6VT44/?=
 =?us-ascii?Q?w3GhYWX6YuQWgNsYjG9mg3cPHML6eZKDBGSzLfsx/+wYwpyzhCF3izM1QJ9i?=
 =?us-ascii?Q?eApDsYIm3UEPfM6cvmtzPdHTau4oMMIUQHwmYjM89dUBkIW6dVbnv8Ln+GUa?=
 =?us-ascii?Q?oiUZko1p6+3i5fx0Q7L0rAVqwBppaWQHNnKs5EdiESHrXY6mY8Mav3iodHYh?=
 =?us-ascii?Q?QIvvsFKECE/Kq/TAYqo6izzlE6gEuJC5MFASEiM9HeO7gQAMWIyDqMTKc9Vd?=
 =?us-ascii?Q?gfD5mTuvi7j8G0jyHjNTyuoPiAah6AyjIjf+SAySwSdQ3ZiAVglA9cwR+l3E?=
 =?us-ascii?Q?4tK6IIDFb7Vp22LvzZCPUH/KNgyUubsqy/dTElFSr8EGUEXutiJHe8B6M5Xy?=
 =?us-ascii?Q?AOX91KzIJv8XQ5ncF/kAML2t7xyPV2CHpiX1Y7dA2YZNgoqjPeNPyLbPOujY?=
 =?us-ascii?Q?fv2IOWlDncCtvjyNwDnneuFj1RveQ1L19PoSlxJYu9kj90BjGZy5PDUsMQ+Q?=
 =?us-ascii?Q?35yXYdcmHoyD7N2+AxTAOddAzkKnRsGUlqT+8zJxn5PX8I+bjixgTb9mnZTk?=
 =?us-ascii?Q?4BAHNP1f0ZwhUAlDwrPvb2Z7jofS7+br8X4JDhP1rtJ1nwiLaFjMKA+jYRkx?=
 =?us-ascii?Q?KASL96E8htCajIeX+Hb2FB7NRf+4ySx365qGkd/fGtDpeZ0TVXSmTjWvt/li?=
 =?us-ascii?Q?bzv/ZjCCcV588KFdEcxKqiIqci8hh9Z6U7XHZekf44PXkth8tzidn+XY0O/D?=
 =?us-ascii?Q?4mOaPkgbuetGS0l7Q1SdMgw6CSpYw5GCLGK9Sw4uO3b4uENGxt5gORXtUU5z?=
 =?us-ascii?Q?zGCOiGk+W0Ajr/AnZ41tPb76NmvM1t6hAdAlDrph4qaPCJCCGlifVqWoc/uz?=
 =?us-ascii?Q?1yVHaNs4rY+B6fUFQQO/xeQT3o+dxN4yNkYQnUSiwOuaxydmbOjCToGQ8js1?=
 =?us-ascii?Q?sA2SOi6TkydV7B5XpxvfXE9W3TgdM6btqIvSTTDqayKdtD2tOnRM8lQO2NXN?=
 =?us-ascii?Q?rc9tuWm6mSrG6FF5soxDDEEPBaL5Ix5MRmzDbhJbckJ0GGyRIKvhx4GGs3cH?=
 =?us-ascii?Q?MhqB8r/HG1uB9lDkT4GS9XQYxkb06q9BLUZjm7BXpxo/RUbbkizbz7RLQq87?=
 =?us-ascii?Q?8SZXsZKqONR0ItRFVhxIA/WKrGI8umiIuwkGVb4btA89svdshQiGY50as5sr?=
 =?us-ascii?Q?Vve2gpPH+boWqo1nYALsVDGlPVBIDE6BM5UoW1RxMPf78zNzvsBrTmtWDdD3?=
 =?us-ascii?Q?NgvFnhsRUr5udcMLf3woXczHgHu4FKXpk3lWRKxYL8aburSgEBtYtoP7hIOO?=
 =?us-ascii?Q?sbb2/B9KSZnHBgLXbUTX3UQgRZ7QIR3zODWTEjrRX5XFGtcbncdTck2SUEvn?=
 =?us-ascii?Q?mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edefa456-7c7a-49b9-bca5-08db0532cc2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 15:33:13.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2m3jz9EsERCSZ8HdVT1WPzvORUCuLSOHB4Vwlt3RKIdeT/Gpn0xlfjKQq8M1XcgqVWtJ51nTZ2jWak+BVx4Iij1uuym7hZbhLAZRBjwQy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1992
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, Fe=
bruary 2, 2023 6:49 AM
>=20
> On Wed, Feb 01, 2023 at 05:47:44PM +0000, Michael Kelley (LINUX) wrote:
> > From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, Janua=
ry 31,
> 2023 10:10 AM
> > >
> > > acpi_sleep_state_supported API is only define for CONFIG_ACPI flag an=
d
> > > thus it can't be used for non-ACPI builds. Initaly there won't be
> >
> > s/Initaly/Initially/
>=20
> OK
>=20
> >
> > > hibernate support for non ACPI builds.
> >
> > s/hibernate/hibernation/
>=20
> OK
>=20
> >
> > >
> > > This change will help adding device tree support in subsequent commit=
s.
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  drivers/hv/hv_common.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > > index 52a6f89ccdbd..370ec20d1993 100644
> > > --- a/drivers/hv/hv_common.c
> > > +++ b/drivers/hv/hv_common.c
> > > @@ -234,7 +234,11 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
> > >
> > >  bool hv_is_hibernation_supported(void)
> > >  {
> > > +#ifdef CONFIG_ACPI
> > >  	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_=
S4);
> > > +#else
> > > +	return false;
> > > +#endif
> >
> > Is this patch needed?  If CONFIG_ACPI is not set, then per
> > arch/x86/Kconfig, CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
> > is not selected.  In that case, the #ifdef in include/acpi/acpi_bus.h
> > provides a stub for acpi_sleep_state_supported() that returns "false".
> > So it seems like the existing code should compile and correctly return
> > "false" when CONFIG_ACPI is not set.
>=20
> You are right, if CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT is not set
> acpi_sleep_state_supported will return false, but this is applicable only
> when CONFIG_ACPI is enable. If CONFIG_ACPI is not enable both these
> functions are not defined.
>=20

Indeed, you are right.  Most of include/acpi/acpi_bus.h is bracketed with
#ifdef CONFIG_ACPI, including the stub acpi_sleep_state_supported().
Oh well. :-(

Michael
