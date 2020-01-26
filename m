Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E907D149964
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 07:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAZGCr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Jan 2020 01:02:47 -0500
Received: from mail-eopbgr700114.outbound.protection.outlook.com ([40.107.70.114]:47841
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgAZGCq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Jan 2020 01:02:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R20/8gLpqt88SUKNXCukBYR7nuLnEqKFY2r9tNasGc7aXHQnVG175YKhY1FEehFyv7Nwr/zExrT/nla/MPlIre6M0570RZ87FFlEBsgPN0TDKYPx+6rPHaYBV+ZZcbnK+39g7SMDkuqsqmI4XoI4k87Xp2sFyg1FReibGhNjAnLRasnCotCDukC3udGrTIYagnE2yAbGRhYyQkWXrd1XE2dSmLZdBO5eukkAGms1PZa+8wHKwFGjFPpb0/qu9Ow7sN3axLEeaCrkG4Fm6MihhHWUDAjQwZihNl3UP+7xtW6/KNHFSo4IQVxVhXxK4ltUDOI5qmARhUh2LpkXFKrEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb9tK1iHG7SrMRYmm07IEQMrqkWXJCaq5KoonFvUoXs=;
 b=TRzqwOPpj0H0Xesg673aBUOrS2UiqDMyuAeUYb6FrcmHrPYFZuuFxZqckJwvoCU60VQiqTod45URaBs9hPq8l6Ek0U1eALQy36mQ+tZ/OtoxVsvjYRX92pYuCDGfRJty6krS6gV7c5PBXmhaF+MbUJmUVCGTILTxKaGDG3rFgKxWXw4nfTCZE46EhSQR8ei36ofuj7Z/nVq1UdlUL97Bf26DHV4Mq/8MxykOeeLvA0Vyeo/uE28YKCx+HCuLP/tdINchY277eVpcSJjU/68gIsA6GIwkYiskiJvpo4AwB9CQIZOvuV6WFMBdoArLzdqW1rJwnzCXtygLlDVAB0miCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb9tK1iHG7SrMRYmm07IEQMrqkWXJCaq5KoonFvUoXs=;
 b=MDAFgsJJQppiVNe0Cwl0oKzNRxXK8kWBYZfrbVlRZp6CWJxkQHMJ5+M5TTGD/DXXqHihK27Y5vubEVMtIfdqai7XNZtYx6Ka4ytQxV+K0ImqquS4K+SUmfmAPdkWFysj7kVGaYgj8kZibXIpuCt6KbPJrv6srJpkeIRayQk6VA0=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB0939.namprd21.prod.outlook.com (52.132.146.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.9; Sun, 26 Jan 2020 06:02:43 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe%9]) with mapi id 15.20.2686.013; Sun, 26 Jan 2020
 06:02:43 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH v4 1/4] Tools: hv: Reopen the devices if read() or write()
 returns errors
Thread-Topic: [PATCH v4 1/4] Tools: hv: Reopen the devices if read() or
 write() returns errors
Thread-Index: AQHV1AyBZGdsPoqaQUKCyJamBEgKJqf8dBgw
Date:   Sun, 26 Jan 2020 06:02:43 +0000
Message-ID: <MW2PR2101MB1052BEF9583E7F0C927A028ED7080@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1580017784-103557-1-git-send-email-decui@microsoft.com>
 <1580017784-103557-2-git-send-email-decui@microsoft.com>
In-Reply-To: <1580017784-103557-2-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-26T06:02:41.4829438Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f4407dfe-7103-4be4-91bd-4410eeba6419;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01fd0e7f-2aca-4fa1-4758-08d7a2255c10
x-ms-traffictypediagnostic: MW2PR2101MB0939:|MW2PR2101MB0939:|MW2PR2101MB0939:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09393076D7C36BDD46289CD8D7080@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(6506007)(8990500004)(66946007)(8676002)(66476007)(66556008)(76116006)(64756008)(66446008)(71200400001)(33656002)(2906002)(8936002)(478600001)(86362001)(10290500003)(316002)(81166006)(81156014)(110136005)(7696005)(55016002)(9686003)(26005)(5660300002)(52536014)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HkaV9Uj8YptYJXJd82aWnciDMfMkr3KCM2m7RWq/hauyVnNpdgBZIM06hzJG7faK6gyPiagwf6YtJoeazcObCelK+42RCjAKwf/B8NWpmrlamtIIpNKBZGq4QDE1mhmAG9yzILIB30vCk1VFebWwwhygN31oZ+zkZSWo0BtyKM14BHhVHT26vkxsuSwsAP4TGan1A9lxlblIatdxx25UNHJFFlgcUvdrh11B+JI+7DoGOUSO7MqaGnM0Nas69OqD1a84Nkrg6j3mvmROx/gdzdAuoQUoSpex1Djug2tJbx+Z8kgRy047StIRtH9DRPKZYb6iND1d6RRm08Ft3npoKmO8E2yUrQrpGyY0SO23O1piEIID1l/EEQ23WTYDliJXZlmlb23EBi0G22oybR6NuWBMpZcowlIWnAgbtFCLxGu2c+YyzNbvfgXlnqVvDDok
x-ms-exchange-antispam-messagedata: mBVTyUOjCLmzCxfghi9QObYmseCJHkPKlGJQsfkQM8M8HDUVMAjNHFCvMfYyJiIxBhe7tFanEhuOEJdxu+5BQjU+9crdEWiSqli3fOOfE4tIkv99KuYT2FzfCc008pdZGCcHXYcxO0ZCtLvp7SA2kg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fd0e7f-2aca-4fa1-4758-08d7a2255c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 06:02:43.6825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVS3h/HK5NITnfUQfp4yX7/qYiRFltWf7z3a5zdSSJbIZl0dtGJ66otdGn00EQqVXilk92ubmCtlh9GLH8vGLYrgGLq1DD3lDUWCmkWsLhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, January 25, 2020 9:5=
0 PM
>=20
> The state machine in the hv_utils driver can run out of order in some
> corner cases, e.g. if the kvp daemon doesn't call write() fast enough
> due to some reason, kvp_timeout_func() can run first and move the state
> to HVUTIL_READY; next, when kvp_on_msg() is called it returns -EINVAL
> since kvp_transaction.state is smaller than HVUTIL_USERSPACE_REQ; later,
> the daemon's write() gets an error -EINVAL, and the daemon will exit().
>=20
> We can reproduce the issue by sending a SIGSTOP signal to the daemon, wai=
t
> for 1 minute, and send a SIGCONT signal to the daemon: the daemon will
> exit() quickly.
>=20
> We can fix the issue by forcing a reset of the device (which means the
> daemon can close() and open() the device again) and doing extra necessary
> clean-up.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>=20
> ---
> Changes in v2:
>     This is actually a new patch that makes the daemons more robust.
>=20
> Changes in v3 (I addressed Michael's comments):
>     Don't reset target_fd, since that's unnecessary.
>     Reset target_fname by: target_fname[0] =3D '\0';
>     Added the missing "fs_frozen =3D true;" in vss_operate().
>     Just after reopen_vss_fd: if vss_operate(VSS_OP_THAW) can not clear
>         fs_frozen due to an error, we just exit().
>     Added comments.
>=20
> Changes in v4 (Thanks to Michael!):
>     Added the omitted "int fcopy_fd =3D -1" and
>     "
>      if (fcopy_fd !=3D -1)
>                close(fcopy_fd);
>     "
>=20
>  tools/hv/hv_fcopy_daemon.c | 37 ++++++++++++++++++++++++----
>  tools/hv/hv_kvp_daemon.c   | 36 ++++++++++++++++------------
>  tools/hv/hv_vss_daemon.c   | 49 +++++++++++++++++++++++++++++---------
>  3 files changed, 91 insertions(+), 31 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
