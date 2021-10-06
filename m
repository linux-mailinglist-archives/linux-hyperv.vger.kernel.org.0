Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502FE42438A
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Oct 2021 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbhJFRAG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Oct 2021 13:00:06 -0400
Received: from mail-bn1nam07on2114.outbound.protection.outlook.com ([40.107.212.114]:41792
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229835AbhJFRAE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Oct 2021 13:00:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wibyc0jnlWITueUPto3IaeJUYdjmHQ3f2GafS6ymtr5yrRXzQofCHBYEC+LUUYqSu3xxi91I3jylqkOUdP3pOrdmpUy7FnlXG64eC386mh/wvQSt2S5minlZ/35YrszXmo+jpsgQsa08pau81P8wvqdC0CCkV/7HtL/X/KRGA/t2PqT2gVBsSSkJtLaXWsFv4zBFoYJ0KhaCEo/DUH0nMv8mZVXuPne+jPzR4n1YsG2bit2TgZNHUr3rO87eOVE9pIOMj1J2eKP5tCmOc3s0KTO4CQ1rIUqUYEVH1Aj0WO/uI+8A3cbYMl0vZ99yFUYpiif46PLfkDI7g9a9yaPGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgkxGaRX8b/fbKOQdGHjP4BfQ+nz/WHWP/7iVP/HvwI=;
 b=LhCCp8nmJj+N7WIK9/rlvuRdAVhoHA6iooiXwK9fo9it/umplGHEM9l1mS/nL+hcGq5V07uwUYOyTHXgNRMXXsf/FS3mGUyDdNI8SB3zxd83Phe0In5oHkY1qzTdTGLAOFmtkkQmHp3wXRAfqUiO60fXD9hHwvr+Io1hezjJwTVeazvOybdK/bjXbtvHMtWFUA9ExztgIIes6CgEPm31Zr8REDuZEVx/rXlkrEbHTsjK5iejSBXgvrbf/R5JwEDIbMc68PoZemS8bB6ykBojZtYDh9IjSX0QNK5n6mhHHhXHX5Fy4dYIVZ+qlkVh+y0yZU+YMr657/CKc2PSFwSh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgkxGaRX8b/fbKOQdGHjP4BfQ+nz/WHWP/7iVP/HvwI=;
 b=eLI1TpYzA4EDYiio9rxyASSPSfbx5OqRnOBVIglscjv4m+tSf/UgV3B9XDxzUt0JOT/nxSZ0ss7FNF/rhoaorNlEY268AYOh8+jJnsOiYk+9j2sz9+Zq+p5+QwDUnAxXVHKy/qAv5vbxO3XDBZFUbc1TzX0wS80PfzRF6xJ+qRc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB2058.namprd21.prod.outlook.com (2603:10b6:303:11d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.3; Wed, 6 Oct
 2021 16:58:08 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::6129:c6f7:3f56:c899]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::6129:c6f7:3f56:c899%4]) with mapi id 15.20.4587.017; Wed, 6 Oct 2021
 16:58:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2] scsi: storvsc: Fix validation for unsolicited incoming
 packets
Thread-Topic: [PATCH v2] scsi: storvsc: Fix validation for unsolicited
 incoming packets
Thread-Index: AQHXurT5XluLbidvpUmp7+iI0FyWYqvGEj0QgAAT1YCAAAk9sA==
Date:   Wed, 6 Oct 2021 16:58:08 +0000
Message-ID: <MWHPR21MB1593CFF82C879AA466FB4400D7B09@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20211006132026.4089-1-parri.andrea@gmail.com>
 <MWHPR21MB1593050119EACC0E49748209D7B09@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20211006161805.GA24396@anparri>
In-Reply-To: <20211006161805.GA24396@anparri>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0786eadf-eb05-4287-8c47-0812e72b578d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-06T16:51:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12309577-1ff0-48d8-a03f-08d988ea7911
x-ms-traffictypediagnostic: MW4PR21MB2058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB205859A9C0B9FC2ED5BE9864D7B09@MW4PR21MB2058.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CtmQA2WnUVjLDaISLOWPRG0IJiJ7HoXygHCQezHazxlUlvTq8Q15f7aSsx3O3sOEUhPMillW4m3bEzKb9vgExbCtHXhoO3azxfcmHkD1hZ9S4Ric1mo/yRuaq/0HrzXuhd64R4o+RXLBKmEpfUuTEu81+bwAolXQB1yhBJqjiDRPvyOswfqWQVJVmoEP59LhPTwCsRBiPw/+2cOe3KKRsEe08gaRjxfHlgOQIEo1Bjfz6Dk6l0CcCynqMkiiosm5wNYGORlXYP4KdimudtoN6cOSqkBhjPFS2kplNPQ8WesT/7Td3rc1HU8OjazC4k7/WBkjm4XDMGMC1uh2QL4Pr9U1OGHvvFeu1V8IHmqMBDIPfDwfE8GbFDi54UJCmBQCnBm74WGpPskshhOEr9KpMmGnN6tTsrOkkkVewzJJoNRBjIxmiVG+DgxZ4FFC2UKFylxfKUwzCu/rF9gA7UK08x4z5RxeOzIBimAhUSsVtKdN3LabJ2tUcpHiEYiXmMb4Vf/oS1zJ2chq3maYnX5gdqfTvt4xL7Rad71lHrgODKXfbJisINCkCCIojM9t2F10POmbi38LeWNHbEuxgphHXaQ4EvDaUjk+N52HgpREJ3x/jEs75F68XBz19/rFK96RA3oIquM3ydxcDTcuGzJz4Vm6jXJispscrXj1wZaD9ozoKT1XuZnm+TGrQcpUMBrX6+Sxyqp13MRySm2F2Ah4p/VLk2rk0gf87WbwF2lb8SU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(186003)(8990500004)(82950400001)(7696005)(76116006)(6916009)(82960400001)(38100700002)(122000001)(86362001)(33656002)(26005)(66556008)(8676002)(4326008)(83380400001)(52536014)(55016002)(9686003)(66946007)(54906003)(107886003)(2906002)(66446008)(64756008)(316002)(71200400001)(8936002)(508600001)(5660300002)(66476007)(10290500003)(38070700005)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bq0tGeUxbyqM7gYAT2XZgkAgX6FG+osoOrzyLxB0ZptE4YnX+IhNTZoeu45V?=
 =?us-ascii?Q?j+F+a9gJ4kfauZKk5hU6mZx7jpZuyU/ByOdDbwMcT+/vDjnpPKfJaenCZfU8?=
 =?us-ascii?Q?DkuMZ/n3vbQ5rCRXpQKcP5iMb28/xLogG0X3cI2IMMypDp8VnRvjswp8s4Jd?=
 =?us-ascii?Q?eJN6IlWCmWRnDu9LMALEGTbAjzZByt3/OmJtj0lwIHFnkYTXVud2CSbHNYfJ?=
 =?us-ascii?Q?I2kbO+pRdQMP0lAyWaWQtt/byD/kNDXdrucq5KJIpJNWsIDCTMWEENk4ilhk?=
 =?us-ascii?Q?XupVO60ofcrwO1YEDKs7QoNC9BO3i5nTtYPEbfqvsN/sV1vt22MyQe74sI5E?=
 =?us-ascii?Q?g2ZLh5wq2TCsdcQK3sYzWcRyx2bU//E3KP4/V6nThI5ZCDjnluQYO9XLoe3e?=
 =?us-ascii?Q?/YAXWI7yq6w4lKxAXBo6zS7TkV5yy8/QRxEqfZu/02uVvKx0OhhKHocX2GiB?=
 =?us-ascii?Q?AxW6lF5v1FJu22dYAXEnlHzKM82i1PNKWUB2e5SkBebymExIbxQy5b+VtAHB?=
 =?us-ascii?Q?BJ33ZXqF4z9MaVNuq+5Ua/lR8ofERYGZbIeYHk/4nbio+B/ybFCoAspxtTS2?=
 =?us-ascii?Q?gq9Etbd5cUFonjV7RXTsA6IoM+C1Q1HQNTn7ptPKeL1kcCs5p8oihOURfeE1?=
 =?us-ascii?Q?3phNCQEANvPE5B4Lpe4xcs2YuEJxcSeUEEMjH0+8/rSohyOtX9yA88Kk5I3u?=
 =?us-ascii?Q?Pf+eaXqjCAidR5mOZ/5wLZySbqWuTTV+W+JDR74m7rhJ4KGO+J56Prnw6veV?=
 =?us-ascii?Q?ocPR6HO8267HVQJh9feayeLiWFl+IPcOcInAdcOCM3rwA1hR6BNv4pG/+t34?=
 =?us-ascii?Q?6p5JveXIKboUyVMKqYRgOHZd2HatrBCX/kOsXWBuM/ziWuC+7gulyfC+Rm8Y?=
 =?us-ascii?Q?byGeFhFBrwaoJFtJUx8VMu/7KaKTRTaYBzJViLs3EK/m0eyDBd8LAQdUxOG3?=
 =?us-ascii?Q?hKD1PL8P58dEomRI8bo7NImawKwAcBy8uKgx7Gd6WEfQjQAX+Yf63x1bmdZ6?=
 =?us-ascii?Q?rhJtyuBFp+0XcFTzRF5fnDEGAsi94JbbQfjUx2B9kOiIKTYOPdlkmi7Vx/Qw?=
 =?us-ascii?Q?IkoEf8aLgjxWjC4dvwbLQ+MRD2U7kkbHaQ0K+vsXBUHj2IRLrlI+qUOeWx9Y?=
 =?us-ascii?Q?Am9gHKGpmbrBidsmaAHp+HKNGhPhccfnIARQbCN92vKNyTDZElRGAw5ucpp2?=
 =?us-ascii?Q?QD2dTDkfouSP7kQASaSWLF9HYOuFldCb7+vDKEz8Libt543NC6MMSllUhO8L?=
 =?us-ascii?Q?D4qlkc7J8coRVKOaF3sLBlVXrLRdChzCjl6IAot8sTI/bNk2Xaox+POYy5bM?=
 =?us-ascii?Q?H2DY5KzdbBY4cuRV9gj8kIMj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12309577-1ff0-48d8-a03f-08d988ea7911
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 16:58:08.2570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ca/J80RdgvY4NQsnWgAoMsYp4YdNBgobAJ5q+m33RUcaX/rFEAtFSc8wh5i7wtE4P1xeD2kMOoDap6he0/pAB7Kg9Ta3DVDdIRTvBB+CQK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2058
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Wednesday, October 6, 202=
1 9:18 AM
> > > @@ -1302,13 +1306,25 @@ static void storvsc_on_channel_callback(void =
*context)
> > >  			if (rqst_id =3D=3D 0) {
> > >  				/*
> > >  				 * storvsc_on_receive() looks at the vstor_packet in the message
> > > -				 * from the ring buffer.  If the operation in the vstor_packet i=
s
> > > -				 * COMPLETE_IO, then we call storvsc_on_io_completion(), and
> > > -				 * dereference the guest memory address.  Make sure we don't cal=
l
> > > -				 * storvsc_on_io_completion() with a guest memory address that i=
s
> > > -				 * zero if Hyper-V were to construct and send such a bogus packe=
t.
> > > +				 * from the ring buffer.
> > > +				 *
> > > +				 * - If the operation in the vstor_packet is COMPLETE_IO, then
> > > +				 *   we call storvsc_on_io_completion(), and dereference the
> > > +				 *   guest memory address.  Make sure we don't call
> > > +				 *   storvsc_on_io_completion() with a guest memory address
> > > +				 *   that is zero if Hyper-V were to construct and send such
> > > +				 *   a bogus packet.
> > > +				 *
> > > +				 * - If the operation in the vstor_packet is FCHBA_DATA, then
> > > +				 *   we call cache_wwn(), and access the data payload area of
> > > +				 *   the packet (wwn_packet); however, there is no guarantee
> > > +				 *   that the packet is big enough to contain such area.
> > > +				 *   Future-proof the code by rejecting such a bogus packet.
> >
> > The comments look good to me.
> >
> > > +				 *
> > > +				 * XXX.  Filter out all "invalid" operations.
> >
> > Is this a leftover comment line that should be deleted?  I'm not sure a=
bout the "XXX".
>=20
> That was/is intended as a "TODO".  What I think we are missing here is a
> specification/authority stating "allowed vstor_operation for unsolicited
> messages are: ENUMERATE_BUS, REMOVE_DEVICE, etc.".  If we wanted to make
> this code even more "future-proof"/"robust", we would reject all packets
> whose "operation" doesn't match that list (independently from the actual
> form/implementation of storvsc_on_receive()...).  We are not quite there
> tough AFAICT.
>=20

Hmmm.  I think maybe we *are* there. :-)   If we get a packet with rqst_id
of zero and a vstor operation other than COMPLETE_IO or FCHBA_DATA,
then storvsc_on_receive() will be called.  The vstor operation will be
checked there, and anything not listed in the switch statement is silently
ignored, which I think is good enough.  We could output a message
in the "default" leg of the switch statement, but it's kind of a shrug for =
me.

Michael

>=20
> > >  				 */
> > > -				if (packet->operation =3D=3D VSTOR_OPERATION_COMPLETE_IO) {
> > > +				if (packet->operation =3D=3D VSTOR_OPERATION_COMPLETE_IO ||
> > > +				    packet->operation =3D=3D VSTOR_OPERATION_FCHBA_DATA) {
> > >  					dev_err(&device->device, "Invalid packet with ID of 0\n");
> > >  					continue;
> > >  				}
> > > --
> > > 2.25.1
> >
> > Other than the seemingly spurious comment line,
> >
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>=20
> I wanted to make sure that we're on the same page: I could either expand
> or just remove that comment line; no strong opinion.  Please let me know
> what is your/reviewers' preference.
>=20
> Thanks,
>   Andrea
