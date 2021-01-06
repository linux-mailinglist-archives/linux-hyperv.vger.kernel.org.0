Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E232EC55B
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 21:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbhAFUuV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 15:50:21 -0500
Received: from mail-dm6nam11on2108.outbound.protection.outlook.com ([40.107.223.108]:9889
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbhAFUuV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 15:50:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFM2XUIzUq0O2+e+KdjeR1yWLnS3P+2WVEG/HGPJkAdSxkGwZsvT1C2EAabypiBnKmF44o8l/CFO1N7VCtq8VzVYNHOktiT+aPvQ+kuJbdwrmdYnx75fWre8/VsA3kd9CYrsa9Tlkwpr4EeTJuNaGUpxbbKU8saooZJFijETVppycfe0BZ/E57RSjpy/MpIGf6UinseqNTOjNlPtEWM8LkI4DvWJCqP74vYDxmnc9XY4HJnvnAMcjkMgjXcv9dXmRuaSZ++UA0cVSVQkZwB1bt0E7jkT4TyV9CCxhd1RHWAzjzHIdDw80wTp5+ij2QBoTtjIOU/NYtEVLg/20pRkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV8ozOu0ZG/OiY6dNjipripMd7Wqh6K0RWUErRh0bNs=;
 b=lbpV3rDhKSw84yCRB4uQLj0X9secfRPd+0NPi5oXBIKGDdeP8Q7ppIla6V1+00RCGK8IBRWOX8pD21PyRceyFh3bu7tUFTs40Yk7P5HheYND7eaaYnP1H1GE85V6kjoiL20bmXQaSMuWJ/Ghh/MZVwF4vrOsAbR8R2kCV51RdJMCz6/VREjoeyKYzgdWlMKgNlghi23Aw/qoEZ8/QtxWv/CE74PzgJ4IvvupqQ4VSIj9ZYxc7sUdvepW4rRk5YciCPOuEYIrASe+qfE7gUIGMuXz1D9SZ9mDv/yT/sRsyequxKqhkql+FC56cXZAcJl9jSYnps097VV0zEeHSKyLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV8ozOu0ZG/OiY6dNjipripMd7Wqh6K0RWUErRh0bNs=;
 b=em+smtXnY7571kYxo7qL5rc6TSvcLvcubsOxBjxBgnvzXFEyktKlcmhVsOmqmZfcPviZYGC1dB5ay7ukQRzoy2vtLpWPCZmsjveqV/fF3jizTibTQRg9nUbuS6GSPLA1YEfDvk6lJheklLxEgzN82zuZ8FBaqGD5XlPm/wtGqlg=
Received: from (2603:10b6:302:8::19) by
 MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.0; Wed, 6 Jan
 2021 20:49:33 +0000
Received: from MW2PR2101MB1819.namprd21.prod.outlook.com
 ([fe80::5868:f11c:ae6e:8a31]) by MW2PR2101MB1819.namprd21.prod.outlook.com
 ([fe80::5868:f11c:ae6e:8a31%8]) with mapi id 15.20.3763.002; Wed, 6 Jan 2021
 20:49:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add /sys/bus/vmbus/supported_features
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add
 /sys/bus/vmbus/supported_features
Thread-Index: AQHW5FKgMmd2hzIYf0moXWkZCcjfFaobC9nQ
Date:   Wed, 6 Jan 2021 20:49:32 +0000
Message-ID: <MW2PR2101MB18199B8BB434D67363658E72BFD09@MW2PR2101MB1819.namprd21.prod.outlook.com>
References: <20201223001222.30242-1-decui@microsoft.com>
 <MWHPR21MB15934AF3CA6C91DB036F7970D7D09@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15934AF3CA6C91DB036F7970D7D09@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-06T17:37:36Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=04bfd94e-a225-4221-b930-4028344b7560;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2dc62aab-fb26-4d1d-c690-08d8b2849236
x-ms-traffictypediagnostic: MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB093864DC1E5AF3916513457FBFD09@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JUPpR0XIZW7tJ+vBgD6T7zQpL47nZhER9Sw1UYFmqdYq8hpJfWQjOMqh1lp0h7jzLAfKunTmbU9r480ziEYcFJzqwbQk4X/7huoombUxqStaQnlaYUO48DJEEL+bf4kjxzqto3GF3QwSqLUP9TQwEqjh5gCIqYGD9quMZaoDBDOJdfVnoWaeazkh5zx0LUZ81WCTiriIPG2a+bSQTSmS6RGUCGf9wrRf3hJaPqZMDlOefjcQgOUzuRR/FTTF7U9nSwBLuPf3YRtV+9WMEMPIPmP2hL4ouZhEZk0FSBkeGNVxwZ5/ft/oxbSiX1pOG5JH/xGVSdu5bycNYiJF5lKckS+Iez8tOjQW2PP4dg+cQEap8Uq1eegJRUCpcb9g/X3P5Ui1sk09QmbhuWp4WcBBG3zf5sFeRjGXbFX824H2aJTg85OXS7ceSpNoUk6TvXO9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1819.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(6506007)(8990500004)(66556008)(10290500003)(66446008)(64756008)(66476007)(316002)(186003)(82950400001)(76116006)(86362001)(82960400001)(33656002)(9686003)(66946007)(7696005)(110136005)(478600001)(83380400001)(55016002)(8676002)(2906002)(6636002)(921005)(8936002)(71200400001)(5660300002)(26005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sBUCXkVqmHI/PIamHUE6w6SyCZxxY75luMBgUZ1G3+burn8mY2WAO8S3E6k9?=
 =?us-ascii?Q?mWofXlWEoc0KdAGRm9j9zm4khUd95M3Ez3r9dgGsSId7DL+vNPZWYc1N4or6?=
 =?us-ascii?Q?7t7SNKnrdnF8oXFh0f3wfFNYAA+z4uqPGNIzOZowXE0m2NSBVL6nhwSY7Bkv?=
 =?us-ascii?Q?GoJZkGt12UpLVMK2VB32pes2HR9Fcgwc33FaHz+NHW5lEX9xWGPhHxjrYZeQ?=
 =?us-ascii?Q?pQm6pkiz4UAIfW5XmJPBF/8uicr5wk6u+GkVgjIDrE6hpKadspplziguq4vg?=
 =?us-ascii?Q?wG7ey60+bemJIrd9yNGiqcrFljrvOwMwwlWRLoFlHdFGryVj1xvywQ2QO34y?=
 =?us-ascii?Q?LUK8xTsew/MDDhiqkJWqISCoxYgttfHC7QDJZze2uBiQh2i46GenLPOAdWAM?=
 =?us-ascii?Q?6LAyGNBMDPk/WklnKUnq3rZE0O7fyGXAGAJF0oWN9dWOxA2/QZOytoBbTt1A?=
 =?us-ascii?Q?viuQ2/xvm6li3lkbKYB7Wta1ryNLfOCF49w5ZxN5erMZ9shauUz/swrklYkU?=
 =?us-ascii?Q?1dGzcStc9SLrPMxTCmSFqg/ApOswkpj/ANhNEnEDHe95tZKWlR3qT4/K66Dd?=
 =?us-ascii?Q?iebbfEg7MBJXDrmYB8n2m622gl55Ipsvh5Wh2DWHUahRBBdve1xjcNCRWj4C?=
 =?us-ascii?Q?cHDP9PDnoSfNGtEEUEIhZVd+C21XW+xsDD3kqPkJ/m8QkNsNmAppnwq2JBqf?=
 =?us-ascii?Q?/obcHJ9AZdVOQyHJ06TfHW0bQE2dn3HOziOjeQsYjCmkretwqlylQb2FLseL?=
 =?us-ascii?Q?qPl4fIjpsWWSFyPkYXwmrm5ZRgNuU37XCkrgFBIdA6y+7P/dIIFMZuCmHdKC?=
 =?us-ascii?Q?lORHhqS/ab5bIWwOlQArwD0jUtHa022WYkA2W3o+H/NjT5f8OyiuJHFc9sjt?=
 =?us-ascii?Q?2RoU32t31O7kygbHounp1CbQNNXLICRBO4iglUIX1+SqcFLKCzMAoKJVukyP?=
 =?us-ascii?Q?8/WMZexUQCs64dzE6kR5NQSnZwS7J7xfrT5GRPTwAx0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1819.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc62aab-fb26-4d1d-c690-08d8b2849236
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 20:49:33.0596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dV8ShGWxRZRUuZd1hTGk0HJv4A+9VBqLJlcubaW9EHFMA7aSH39ffbBqaN0BElW5bkzMwB46O3iBJLA8y/FgxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Wednesday, January 6, 2021 9:38 AM
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Tuesday, December 22, 2020 4:12 PM
> >
> > When a Linux VM runs on Hyper-V, if the host toolstack doesn't support
> > hibernation for the VM (this happens on old Hyper-V hosts like Windows
> > Server 2016, or new Hyper-V hosts if the admin or user doesn't declare
> > the hibernation intent for the VM), the VM is discouraged from trying
> > hibernation (because the host doesn't guarantee that the VM's virtual
> > hardware configuration will remain exactly the same across hibernation)=
,
> > i.e. the VM should not try to set up the swap partition/file for
> > hibernation, etc.
> >
> > x86 Hyper-V uses the presence of the virtual ACPI S4 state as the
> > indication of the host toolstack support for a VM. Currently there is
> > no easy and reliable way for the userspace to detect the presence of
> > the state (see ...).  Add
> > /sys/bus/vmbus/supported_features for this purpose.
>
> I'm OK with surfacing the hibernation capability via an entry in
> /sys/bus/vmbus.  Correct me if I'm wrong, but I think the concept
> being surfaced is not "ACPI S4 state" precisely, but slightly more
> generally whether hibernation is supported for the VM.  While
> those two concepts may be 1:1 for the moment, there might be
> future configurations where "hibernation is supported" depends
> on other factors as well.

For x86, I believe the virtual ACPI S4 state exists only when the
admin/user declares the intent of "enable hibernation for the VM" via
some PowwerShell/WMI command. On Azure, if a VM size is not suitable
for hibernation (e.g. an existing VM has an ephemeral local disk),
the toolstack on the host should not enable the ACPI S4 state for the
VM. That's why we implemented hv_is_hibernation_supported() for x86 by
checking the ACPI S4 state, and we have used the function
hv_is_hibernation_supported() in hv_utils and hv_balloon for quite a
while.

For ARM, IIRC there is no concept of ACPI S4 state, so currently
hv_is_hibernation_supported() is actually not implemented. Not sure
why hv_utils and hv_balloon can build successfully... :-) Probably
Boqun can help to take a look.

>
> The guidance for things in /sys is that they generally should
> be single valued (see Documentation/filesystems/sysfs.rst).  So my
> recommendation is to create a "hibernation" entry that has a value
> of 0 or 1.
>
> Michael

Got it. Then let's use /sys/bus/vmbus/hibernation.

Will post v3.

Thanks,
-- Dexuan

