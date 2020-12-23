Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99FD2E21DF
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Dec 2020 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgLWVFM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Dec 2020 16:05:12 -0500
Received: from mail-bn8nam12on2109.outbound.protection.outlook.com ([40.107.237.109]:53856
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727605AbgLWVFM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Dec 2020 16:05:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glypXcy9i6pWbPyG2fbVa8OKua8LK78Vg9BtC7ESnUmO7SBwXvGSpvhfIUnI8lwS1YTTcMEhsqESHjOLz8I3WF/sfErs5fxoyEEZFTeGa5uFTICD8A5saP+K5yX2BlUnrRVmbvjAySsL33zz537aWMg9H8kEQjZZ3FMRmsFbQ9V0lWgDG0/+rZk/yEMNG4nCV/rrDCvibmMrCqH408Pevfr+SRvkOi/4E7RqSjv/nTNDiDOOjRx4R8vYZotG7TVR08ihzNYPY4EVBIm6cKgDJcG8nYO+f0GLZ97d0SRGd+d51cGGaOANj5Wn3U4fCbYd5WM1yRKUc2axbuqDiQO9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASKyFzeyuAukav9tpDVgwDak9DpiKcpmO3XA0PsVQy0=;
 b=oItkjFtMsswTjezBQSeraZWca5HLKAWmf09JM8u2e+cieuX4tVFA70tHOJk8eKkXg7MHcB6WXfRSJ5ch6aJ2Hk310VREK48NYNyeHHvmJdPXxs5TxPMibWAwKOVVw6gm0+mWr3veh/cno4LgjRTOABdY6lOXw9XJmZdGPJy4FwPMViZtmcfjIapXRkrUaoPpbDrezXa4ZlX2RLr6wuvAX6v3pp7jXCPGt6Vp9wVvwbKIqA4UbPKB6OEzc6AyIGsitnyuZ14ylHvduC9/JhBhuKBnIGPx4IYFbdGMdppGyEROrqdppLbRDu4nx20645Gwd058DDyYPH7ZYC0qj809uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASKyFzeyuAukav9tpDVgwDak9DpiKcpmO3XA0PsVQy0=;
 b=QSrUlASMz9DJPtVkhLVl/ypXujQV+PIfrICTQY1v4xIW42Yp68x7DNpAE2c2ZFDvgeH2TiKm7oQyT3Nd/oeahOPds5fCgny1v6CDGhEqhUbQTqpDzVM0Nr+KaVJso/VxZ2FdSqXlCDt5DEkXmXUXBbEJWv8P/Tq1e7oHyopwXTc=
Received: from (2603:10b6:a03:297::10) by
 SJ0PR21MB1871.namprd21.prod.outlook.com (2603:10b6:a03:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.8; Wed, 23 Dec
 2020 21:04:24 +0000
Received: from SJ0PR21MB1872.namprd21.prod.outlook.com
 ([fe80::6c27:2cfb:ebc8:aaf7]) by SJ0PR21MB1872.namprd21.prod.outlook.com
 ([fe80::6c27:2cfb:ebc8:aaf7%6]) with mapi id 15.20.3721.012; Wed, 23 Dec 2020
 21:04:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: How can a userspace program tell if the system supports the ACPI
 S4 state (Suspend-to-Disk)?
Thread-Topic: How can a userspace program tell if the system supports the ACPI
 S4 state (Suspend-to-Disk)?
Thread-Index: AdbQHxbRjXJd8DrBQaCk5mureoGP6gHrXHUAAGiEKXA=
Date:   Wed, 23 Dec 2020 21:04:23 +0000
Message-ID: <SJ0PR21MB18729A4AA7EB4C04ECAC18EABFDE9@SJ0PR21MB1872.namprd21.prod.outlook.com>
References: <MWHPR21MB0863BA3D689DDEC3CA6BC262BFC91@MWHPR21MB0863.namprd21.prod.outlook.com>
 <20201221190731.GA19905@amd>
In-Reply-To: <20201221190731.GA19905@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ad444f66-85af-4361-aacd-cef96089c74e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-23T21:00:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: ucw.cz; dkim=none (message not signed)
 header.d=none;ucw.cz; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:f58b:1960:7f38:83b2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1adfbbb-6f99-44a5-ae46-08d8a7865373
x-ms-traffictypediagnostic: SJ0PR21MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR21MB1871645D52A054E5AEE51E43BFDE9@SJ0PR21MB1871.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aKjm8BV+CZ3RMS/iL25AsQ5FJk9enupmSjOc1I5ZWrs/90/eDmkTH6VJ/RgUDmuRx5sKqckkgMTe+PUk5KqNU75WgU2qzI9qEX+lgFUga67AUauAscn0SNZB98wpunRsvYky47EN28FDVb+2DBOz6o5PwNBJz+7hAgzOpyEcnHPEpbJUhtf411fTCsG54/ZuLmnZALXxOliSg+jvmqZ4poHwcGPrWLxgp18E6ALajMTXHHXYBc04ap3lOG6DG+LYYabEAGB7Wyz7FdLYEWna8+BGm9UCmFm/9Vx7jWNRcVX2mjecxACAK9sa406IFvKQJ7nrL9UrSCDMuXhg6AG7taOgQAt8AJfSNd+Gx3h9aSaMoTxQM2I0BmkGQ4uq+NiCaSoIhr6hvIh9xBM+7pRfq/mDUfnVpZuBsOcUN0O1i4i0AegCMXK37gyLU/1qWpDm7V5Havc/mIRGZxfEHQnPew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR21MB1872.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(52536014)(8676002)(2906002)(478600001)(8990500004)(4326008)(7696005)(6916009)(83380400001)(316002)(76116006)(54906003)(186003)(66446008)(66476007)(71200400001)(33656002)(66946007)(82960400001)(6506007)(82950400001)(8936002)(66556008)(4001150100001)(9686003)(10290500003)(55016002)(64756008)(966005)(5660300002)(86362001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YFCLEre0xElrUfOu53ajx4K/7hw83f+9OuDxyTW8Na/uPYbeDbiUm4U1CnPs?=
 =?us-ascii?Q?OT/80jbxOpVu1do1wJ6uqYPIyFr3qqhAV3fTAWy/lRcDPdcMlzvyls3xIx1A?=
 =?us-ascii?Q?wlt/rM0HNocJOB1qGYqpRkLY+v1xbSHCTL5lNcQSA3T4hWlelupkN3+k0okQ?=
 =?us-ascii?Q?Dd4/RUoOsvdz5SeBeBjXKjBFR2SYuEnrtgrfCDpsk0UOI53nlE5D96w1XpB9?=
 =?us-ascii?Q?U+un/ORJQGNq7K6PDFiQMHEAZ+LkOT0OcbwN0fVzOFGnkSGorboLDZE+dJSK?=
 =?us-ascii?Q?34VUPaqiC64XfsfreqSRJ1qufyFOt5OHbaEXz6scTPaO8zWyGH4r80Shb0fX?=
 =?us-ascii?Q?bi4zcA2vcrmhDiNl/VccER4CfU2/7s+kDwpYYtxfDBum/Ak0iuAgn2zHbMy5?=
 =?us-ascii?Q?X5XSjbWS7mlE2hzgqV0v3/UOuqC5kLxdexzJ36Fk1wWmnqNzoCTBCnqUot45?=
 =?us-ascii?Q?hKwre8gQHUkk5ymp5UeHZlo6Xi+c5HvDZTUClHWr+xisgJH3oCTHR3PZmCXy?=
 =?us-ascii?Q?jAmm9rmzupydCxVBgBniLNbxIaMD46INX0aTAJ9qE+atWz5Mrj98wJ9Bi14l?=
 =?us-ascii?Q?iKabjcazzDrLyzK0AI5qjre6RjwB883pD5RyFWsnavOc2grV+oL0wMewSNO+?=
 =?us-ascii?Q?1UPPnVgAKFZatHH1dwZJXQ6gWew/HDSTkk4MH96HJi9gdyx2KvvVfV8/Vdfn?=
 =?us-ascii?Q?TSmgc6zbAfx/sk+x0EO4LebpUuDgQvDvB792S1r0CQGoggPsmccrgyJ7mmoj?=
 =?us-ascii?Q?0NdCijyS407S2QASTiQRTpjAqadYjASPgrQc4QFdHr41h/yIWgKUle4t9YQd?=
 =?us-ascii?Q?sG+9XcsjOoisQndspN7I+bFuIWmJkOpNYXDpEvsObkOdfUrfJb6ePijCEXqy?=
 =?us-ascii?Q?/DhtToEa2DNRDhkZ2/wfsPyo7IOzoUkaUBTtcRw2yt08o0sptgBurYmY/Z7S?=
 =?us-ascii?Q?Xmo7Y8v7yy3DMEAbP1008lZNHlNY6VLMYusyPC+btn3bvkD86OxWw+lKmbwD?=
 =?us-ascii?Q?5HSBLDfWNB4C87vnxWMYGgpOBOiuHq6fUpAOEF4MIMRaWbw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR21MB1872.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1adfbbb-6f99-44a5-ae46-08d8a7865373
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2020 21:04:23.9625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RV02qIDIloZz5ChHcTnnCr8J1qlKvd6MzdN4jJk0nXGPMhdfNe+gIgaEqSZG2vL6GBFKrX0NkfGhGMYDtazAsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1871
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Pavel Machek <pavel@ucw.cz>
> Sent: Monday, December 21, 2020 11:08 AM
>=20
> On Sat 2020-12-12 01:20:30, Dexuan Cui wrote:
> > Hi all,
> > It looks like Linux can hibernate even if the system does not support t=
he ACPI
> > S4 state, as long as the system can shut down, so "cat /sys/power/state=
"
> > always contains "disk", unless we specify the kernel parameter "nohiber=
nate"
> > or we use LOCKDOWN_HIBERNATION.
> >
> > In some scenarios IMO it can still be useful if the userspace is able t=
o detect
> > if the ACPI S4 state is supported or not, e.g. when a Linux guest runs =
on
> > Hyper-V, Hyper-V uses the virtual ACPI S4 state as an indicator of the =
proper
> > support of the tool stack on the host, i.e. the guest is discouraged fr=
om
> > trying hibernation if the state is not supported.
>=20
> Umm. Does not sound like exactly strong reason to me.

Hi Pavel,
Thanks for the reply. I realized that it may be better for me to add the co=
de
to Hyper-V specific driver: https://lkml.org/lkml/2020/12/22/719

Let's see how it goes that way. :-)

Thanks,
Dexuan
