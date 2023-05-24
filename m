Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5AD70FB62
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 May 2023 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjEXQKI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 May 2023 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjEXQJz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 May 2023 12:09:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09AB119;
        Wed, 24 May 2023 09:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwQekJ0wUk2N6hVcCEZCakQFQBRTpcTSs10UKtsTACQB5PiZOdjGDnm33XeUoTaC6FtAbPL85FV9j7ni1xHU8wS5w4pTwAhya4NdXMHGnSzQmt6az7ojCDw1twpLO3z/ZrTO78eMF6I976r/c7iPwtAuz4yWGNIBAdhNUxe6gbqn7mdfokbIC/MSmyvlF6c+S1ewEgVRw8rIyvlAeZIZKCofbXkl2zb5bZswbv9uAy+RYthkH+AMzZFSYtW6WAI8SncBASM662/Q7M9OiS2cOGB1/W7xpRZYwIgwFlek5Qb3epi29xQORXH5oDnxZtg5xi6iM1fGaHTzSNJRkug8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nPvErMAfaVN8hxIiVOEHrAdewecsMq7D3dGknuCrZQ=;
 b=CqPQuevp79EF/q9NX+6s+dUZTOPYr1CfQKTRuSMglaow2PRUUSvbADO+ivRwdlDgjXM81Qq8ZKn1/WKm63i68J7a+fnk6YjJBfPza2Xf3Y/E2RWhe/NW4OSRFGa6mKjNA0fblpoRUyzUyD2La6YVFslV/XFzfRPlRWqh26RQ2ZlyPZBmWN494wUKGcXpia2VTyj7oV7tY1fRwFMe58BBihUwtNduqEGyX3Pq6F08SAItkvCoBfst6FXNUL54hqRy/4G2IewpxO5zvCUoEMua7IczQ9i+Z8ytaj+16KWe5qQ1Bc0pDw68Gp1VwIJDz6jHGHplenOOpJPIFFhQrdDNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nPvErMAfaVN8hxIiVOEHrAdewecsMq7D3dGknuCrZQ=;
 b=E9t5ogYh3qLB3x0qThWp3pBC8gz3ZV3pwnbEQeQCcJlkey9C7H/f6hTZjx8Hz1DXWrl1SShxp/WqbWzmXVVhaY/xpX21XYrOAjW0QPtRpk4IAUYXeYuzp8R4ukmiSWpMzoOKkSG9SzvZC+odecfn+8KR5istm3ZsjyZR2ENzWEs=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 TYZP153MB0400.APCP153.PROD.OUTLOOK.COM (2603:1096:400:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.6; Wed, 24 May 2023 16:09:47 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6455.004; Wed, 24 May 2023
 16:09:47 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 2/2] Drivers: hv: Kconfig: Add HYPERV_VTL_MODE
 dependencies
Thread-Topic: [PATCH 2/2] Drivers: hv: Kconfig: Add HYPERV_VTL_MODE
 dependencies
Thread-Index: AQHZhBiTYeqvuruPeE2EOZkq3i12Bq9jbhmAgAY7z6A=
Date:   Wed, 24 May 2023 16:09:46 +0000
Message-ID: <PUZP153MB0749EAF0A46D0DBD82640B9FBE41A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
 <1683816877-10747-2-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB16884CCC195B1D90BFB30D0CD77DA@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16884CCC195B1D90BFB30D0CD77DA@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c4755354-b2f0-4b02-974e-488479445ce0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-20T16:39:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|TYZP153MB0400:EE_
x-ms-office365-filtering-correlation-id: 86e2e885-6ae5-49f4-58d5-08db5c714b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDoE4GUj8lt5eQZMLS1t3PLC+A1xk0JEpMipz4x0gA6zPb5SLyy2kWRrRLi7Z+yPF6CiM+xqNjsEQdklLZbX1M2wEuWXl8xBCJFCLWLX56dvx3XN6tGxUH4kaxBxJUa5bkwKwtybxENZ3ENnExaxFmAOrvZizPekgVMj6VZ1t+grYoMRDYXQxTKH5FE5nGd9mKdQQs1nMyhlghPTX3P5ReJx2jjGFRyylUaOGR7/a5T7xlYVuGKgAJ5G3SyTy1mbfrEARi9cd4cL22VeU57UaLzlRb29pxJ++bkmB3XYo+tFPHyClywirQf6SleSQtnohx8xFi8O4HdO0+IRXvu9oZ/p9Bk6dFPrWYGoZ7GEgmuGqmGjqKADfX4MbeGImCnVFR88WtnbiFxLPyh7XOv4xCNOJuNKvoV+wZnyvjaYx1hg7Q+Q4Xo+V+NVR7a7+ZlhLPUghtsrRFHVFag0m/5iRP418nk0OTTh2wZkJEbzTt0cos5eSY3cqim/iX+DRcCLoxmPEqlUMNzsuZTHljCxNJ4dqBDA6Cmn+4O1f9uY+t1NZB57ZbUwcZjjhqiJMvJM6iIhMjUOTq/Kh5vBEPbE1UNtXQtzbvBzMRxIMdb8PSawsZv3cTmoY50Ch8reKHs63TNofxtC1h5MqSRdtyR72kpQP25CJKdP7y7/S/komGh1ory8fp+7z7ZIzHv6fWul
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(38100700002)(478600001)(82960400001)(82950400001)(921005)(122000001)(10290500003)(76116006)(66446008)(66946007)(66476007)(64756008)(66556008)(110136005)(71200400001)(83380400001)(7696005)(38070700005)(786003)(316002)(41300700001)(55016003)(86362001)(8936002)(5660300002)(52536014)(8676002)(33656002)(186003)(9686003)(6506007)(8990500004)(2906002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?txYHwxBjPdkjjk8ZOjv4yFifs31+nYkS+v3HK3Ga57K7M7pEUobeg1YR1fvf?=
 =?us-ascii?Q?tMS5VdX21a2GPbLC5DebKhFrLes4yh15mj/+QVzinl6upel/lWrTiZ5XBAni?=
 =?us-ascii?Q?VLuAwzVpnK8qHdhisJZnUQl3UeYaEewUBXxq29kQqfJQnH7bjgur9e8+aBAu?=
 =?us-ascii?Q?6PK3r3GVf0u88UzryesZn0+4YM/k1Si8900eXPA75HaxmX2EaceSkKvzOLdm?=
 =?us-ascii?Q?b0r4F1HC3sxGktQIlOuG91wOogbA8oN77KOm729z0lhd6QrqppveI2pnpqsi?=
 =?us-ascii?Q?+yGXNgdnzFTY+OcAU+GIvjBTifEH4G3rggbNnhrN8odyK5vymjJJ8gJ9BDzZ?=
 =?us-ascii?Q?/NK849ysfHEwG/la2JDD5ynOTNPqHX1pWz7m991tHEdhNMZY2Fts5GHOEw1Z?=
 =?us-ascii?Q?ozz2toAbB78pRtC+Q8f6W5PsO1LLK6nKB0F+u8MBfZJdbYkk1EEyBR7Hlgkm?=
 =?us-ascii?Q?WmULZWQIa6qnVkLM4dHUJ+PBD4iOJwUGgjwFiMVkHDG9DxLm05HEifegHhJW?=
 =?us-ascii?Q?umXRrdf4XL942RAYM5rwIvXWLQzLlTl9IXKUVtIZgpLGqqrCpXZWl2W0Xjf5?=
 =?us-ascii?Q?VFuXqUspF1jI1WtxZPR124V5Pdz1lygBgQBKVa9pdTuoyBdSd3xPeAUoa4xE?=
 =?us-ascii?Q?cPQwCJ3Tr9Lf3qy/PJMtwLPYtElHvEO2FrAaRQsCviGA6bU9YERYbscdDKUJ?=
 =?us-ascii?Q?N5MCT0U+t462MHcO/RhtzIOe3ZwPEYYLt9QpAmgXrAR+nuUbKmAXSsHgBKF8?=
 =?us-ascii?Q?RBHShCeTV+DgmgQglpGXwB978fFLseYjwXLyU7tXH/lOVUn2jdJdiYFUhlA7?=
 =?us-ascii?Q?hY5QUgn7kicheNmTd4QewRHXQngQB/PMySVPoMLysXIwRtxV6aomILkgiqTY?=
 =?us-ascii?Q?CVOHGkG5dFGqpmEYEwWwjfFCvsiFg8j8KQRZ53e6CH8PBeD7gXRnYbdXF5f6?=
 =?us-ascii?Q?FvYHsax/krHPhErz7WgZN0P7VycGCUjXk+whXWbVdM2xV0ZBLy3KaRpe2XtD?=
 =?us-ascii?Q?O17okv4STKzH09xrF+CuOEczbU0gxd8ujzcX1R6qnj1zXBXxs0qoaNReyT4a?=
 =?us-ascii?Q?Cck5xIuC9aIY8h6lxbxA3mil0Ffu+m7FOU44zucaMQ9q9Lo/KCZ4gBbUAeaR?=
 =?us-ascii?Q?2r5nLbiOvvi3Ode8dUFo5bFtAVWJ1RzKvRwvq/fKbmvRZVYQx48EqFViJm/5?=
 =?us-ascii?Q?T/DZJ+BYXgLM8M31HDSXwpRG971bkFMWudP4uWtXnEzs8knF7qkrH/+3HKcf?=
 =?us-ascii?Q?lMJIpgEa0ohP2C2BgMBlBF27JJnoxLDYukHDp3p84X4eQeVlD4UF6IGCKYP2?=
 =?us-ascii?Q?btQOVY7XC145aYpjmL0rO04D/CR6K0FE4xFsMh+bY3GTzlN6mpaOkmxu/1wi?=
 =?us-ascii?Q?wKwVnAOQfP7OCM/BDeLFs3mSF6WLEIIo186VZcjPR0eskLD7Mv3+zgCq264g?=
 =?us-ascii?Q?cgX6gWY2kUyjzArAlRm41tm0fgMMv6OXm5BQazjgaG4SBB+GKTotwuc1bM4s?=
 =?us-ascii?Q?Q+6fsXpEpRV/8NHPjkw+ggZkjWIRYGs4ANjWThQmKNTT6klXASWZMnO4Rezo?=
 =?us-ascii?Q?E7467xn8khksvx/t+iR6PRju7JAVpfwmmab70Lz7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e2e885-6ae5-49f4-58d5-08db5c714b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 16:09:47.0222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vaBAIJje5GTF5PhF6oPvjnZ0HkN5tBICVPhRNlxcP9OzKGTlaq/yQ0kw969rF+UT9B3MVaDnU56ZpCWgx41KRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB0400
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Saturday, May 20, 2023 10:20 PM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com;
> x86@kernel.org; hpa@zytor.com; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> hyperv@vger.kernel.org
> Cc: Saurabh Singh Sengar <ssengar@microsoft.com>
> Subject: [EXTERNAL] RE: [PATCH 2/2] Drivers: hv: Kconfig: Add
> HYPERV_VTL_MODE dependencies
>=20
> From: Saurabh Sengar <ssengar@linux.microsoft.com>
> >
> > MTRRs are not per-VTL and are controlled by VTL0, make sure it is
> > disabled for all other VTLs.
>=20
> Clarifying the wording a bit:
>=20
> MTRRs are not per-VTL, but are always controlled by VTL0.   Allow
> building for VTLs other than VTL0 only when MTRR functionality is disable=
d.

Ok

>=20
> >
> > X86_MPPARSE scans low memory for MP tables, which is not required for
> > Hyper-V VTL platforms.
>=20
> Is the above statement saying that MP tables aren't required, so remove t=
he
> code to save space?  Or is there a problem/failure if MP table code
> runs and scans low memory?   *Requiring* that it be disabled, and the
> reference to scanning low memory makes me think it might be the latter, i=
n
> which case I'd suggest this more forceful wording:
>=20
> The MP table code scans low memory, which causes failures in VTLs
> other than VTL0.   Allow building for VTLs other than VTL0 only when
> MP table functionality is disabled.

Ok

>=20
> If you can give slightly more detail about "causes failures" (a panic?
> some other problem?) that would be good too.

When CONFIG_X86_MPPARSE is enabled, the kernel will scan low memory,
looking for MP tables. In Hyper-V VBS setup, lower memory is assigned to
VTL0. This lower memory may contain the actual MPPARSE table for VTL0,
which can confuse the VTLx kernel and cause issues. (x > 0)

>=20
> Michael
>=20
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/hv/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig index
> > 00242107d62e..c8d443886b9d 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -16,6 +16,8 @@ config HYPERV
> >  config HYPERV_VTL_MODE
> >  	bool "Enable Linux to boot in VTL context"
> >  	depends on X86_64 && HYPERV
> > +	depends on !MTRR
> > +	depends on !X86_MPPARSE
> >  	default n
> >  	help
> >  	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> > --
> > 2.34.1

