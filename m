Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABC2423224
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Oct 2021 22:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhJEUhz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Oct 2021 16:37:55 -0400
Received: from mail-mw2nam12on2126.outbound.protection.outlook.com ([40.107.244.126]:17888
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229805AbhJEUhy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Oct 2021 16:37:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0TSNUmQ4Yin6YrCyoguoFifqXp+gtGNIe1NZ3Gslj9GuWZb6gD/e1Upq32ZlFyyJfaHFcPdCqJaiD6v9FOY4qEwxNVH1bjY88INtnIjS0HqoXohRnXQwiQNgH/j+kQaXouX9deqY9wN5/QkCSMReJ/LK4fQvuYmApfCKQRWYzfLj+pd0eGzxA4KPqV6Mge6xdqP9g7JuZpUdvpDORsxFUCmq+kLc+4eV6IWEb1s9KIrSnTENQLNAla2NF+fu7qTkZ28Qv1GuAOMaxsMvzJ3jJET1B9Mw2tlk4yb2kHS7qajUx7Txigmg4DDGoPf7fOEtAFjV4UACp40iNr7NaP1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xvj8iEkyieyghBscOdgrfVWGAC1iS0VLbXbFP5lVbdk=;
 b=gMUWQ1qUq/BjX0ljXeXG6QFXnWVsxpv5JggkXgRgzl1RnNhdtWw8Op3m5E7yCQ2+Ud85aM7lmFqwJNlcqUY8bKz37XueLh+f3wOe7XDY4BSswNKGTiWePzEIFKSC5NKgVJ+JLukrDdzmitZwmP9BbhL4ywUv2Cr/QeSebcpPghXcq3g8b+rBFnBR7qG8EFqxhWviwCvvNW+3Gf2h0uOe+NOr54Pf52ePrHh7dKfUHLOrGi3/SYQDQTMPnanGscOJN3pPImdcHnvEnzOJVq1WFxAtlS+68tLRHRbTOM8HMfACvOV0244jNQAGBieGjlvFAiLJgZ7aqSieWv86DCWtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvj8iEkyieyghBscOdgrfVWGAC1iS0VLbXbFP5lVbdk=;
 b=j159jCsnddA/Dltj/9oM2qpPIHaZCitoMPQmLSqmT26YXJDZEbB5vzTzkR+pBAwTfawATsHFrAPS3hO/Wgv8rYAvLwELLPRn/WLgl8mWFujO8aLur6g5mX2zmxffsj85m3b3otcVkeZcidgZRlwtNBnIEMxyFhGoj/C7bt5u01U=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CO1PR21MB1297.namprd21.prod.outlook.com (2603:10b6:303:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.2; Tue, 5 Oct
 2021 20:36:01 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::6129:c6f7:3f56:c899]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::6129:c6f7:3f56:c899%4]) with mapi id 15.20.4587.017; Tue, 5 Oct 2021
 20:36:01 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        Long Li <longli@microsoft.com>
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
Subject: RE: [PATCH] scsi: storvsc: Fix validation for unsolicited incoming
 packets
Thread-Topic: [PATCH] scsi: storvsc: Fix validation for unsolicited incoming
 packets
Thread-Index: AQHXud3qUC3u++ARO0md/Bl+ITMuDavEkGRAgAAlg4CAACJ5IA==
Date:   Tue, 5 Oct 2021 20:36:01 +0000
Message-ID: <MWHPR21MB15933E46ABC6DC0AA5DD0A5AD7AF9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20211005114103.3411-1-parri.andrea@gmail.com>
 <MWHPR21MB15935C9A0C33A858AFF1A825D7AF9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20211005181421.GA1714@anparri>
In-Reply-To: <20211005181421.GA1714@anparri>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d5ecefba-b229-439a-80c9-65f63386ab4f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-05T20:17:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dd37b21-c014-4306-92b1-08d9883fbef4
x-ms-traffictypediagnostic: CO1PR21MB1297:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR21MB12977EEF0F33886F8A7BB821D7AF9@CO1PR21MB1297.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OO0BZBEuRJSapZe5e9RbkB77jkLqOq4uudUtFRakkDpgH2Kg7oG8whshVoELHV8Osa6XeSskgE4z0247OYQcZlLvJVtOVpI3QUp52C6LMRrJlNwlc7b1Y+rCNsesFqh6z7YHW2og4sYxBX7MIdY9XJ5I2nyPpIbcYNxd5lZVaX8rjQE5hcBtVCdCK1+EFeE9BJtV8kxTqJyuCqsUNaRSJ/mWX2Ii/PBJywntHG3jnkPHMftyVygWzxFqEwt/JuvgB+OEOzCk7dfoosIO8TOGDoQVfMEWwraaHX3UZ7CbqWntMO19uFrjNc6+d9768ml+98+2vPCBc3inNV7olxmaFzJhxJfKhQpxDZ4QpQUhrkq2HsMRD/4m+T85nDopdMYn3r9/2bydujPfD6liFDfPEroTgvg74T8+6d4O8gUDaThXpYdzKyIzxqKV3zG0x7IWrR5mcfMAeOqPvnDGFc3Sv3O2pt6htR1UcBU1b6MluAQD+Nfdgx3LaICP48dTyJFhQZ7QE1oAMnEIh55FF8ezwhrmP6A8DfnsVHfcNcAvt1UR2C2O1BobKBAUY9y9DS0E7KhD694Icx3JyZsrd3s4rNNtuKEmVVCdiVJDIyoKIk4fHvQz5DuGdT4aeBcDo8VYDSAs7RSmlXOWrexEwvTzo3PN43T10ZeyyumZZ1ZKybLLJg/W1Ak7bInJtCEOvMc/NflnqaL0iYFkDrdlP9kaxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(66946007)(82960400001)(5660300002)(82950400001)(107886003)(26005)(38100700002)(122000001)(508600001)(55016002)(9686003)(66556008)(66446008)(186003)(64756008)(4326008)(33656002)(110136005)(83380400001)(54906003)(66476007)(6506007)(7696005)(38070700005)(316002)(8936002)(6636002)(86362001)(52536014)(8990500004)(2906002)(76116006)(10290500003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WStZU1/hMF7qMMeqfvgT7JwNxddeSzMtO5eAp7QAqDwaZ/DdJPOFMbQ/AHWI?=
 =?us-ascii?Q?fmbKuiNWhoCix950RT0GmcJKOmqfuveUEKSeC/g232ueOu/sHr3Oai4F5fc8?=
 =?us-ascii?Q?0E0AI9flG+jcQ+8fad1nVIMHFvpMk0Nus3w5DSoauNeJeMT9Gi171b/1mrXn?=
 =?us-ascii?Q?fMzBQyiScme6U/sFLNNly5okH6JuEtBoQ5ncFk+OSKBBk9wX04UUiNRjF1n+?=
 =?us-ascii?Q?VN23gwxgrcaFe4fz4V7S6odZnrFEMe0zNBe7TmaCAbbONw2UjPGRpQyMVhyG?=
 =?us-ascii?Q?SmJHxidnwVG1/qJgUrT84a3LZi9T4PClzZz4FJVfqt3ZxCO9dqztHkD3Jft/?=
 =?us-ascii?Q?mXVlPzjPMKUARl99gHfMkCN9Sciuliw2c5exmjIexSPoGKQt58PVNNo3kiS4?=
 =?us-ascii?Q?89CfStIqZkDIzqO9AR6BvVZn1uJHZaik9YZehmxHJscDIC1vWTetUqeDgvKy?=
 =?us-ascii?Q?yDYZV4SmGSjahtnoye9iMm5gH+nbXtXr7esW4uhcS/3ItIRp9ZRJ27TNRRSV?=
 =?us-ascii?Q?LWG6enzVdTSgR7LhZyuXNDhIPx2a0Jy4YbwGQhHvxxXD61pOWf8G8pqjr9eu?=
 =?us-ascii?Q?vaLPRAqH4ueHy1457ibi7DIH4b3crnYbA3Z/CGfpdCvHL6tad8xsA6ceq7Ef?=
 =?us-ascii?Q?1ZG9J0rUkYxbJV7rV2fh+tHTywz40317wsprumeEexldN9CYfI2vSNTGUaR1?=
 =?us-ascii?Q?fjLKGCT2RDDCkLCSytnpHHigWlTAV5fFBVTqgAlC49Ukm1AurE9SGf0xyBD/?=
 =?us-ascii?Q?0oGWu1Y3b+YOKEsVO8GYtvTmbXuk1YSlr8jLgu0SGaj/JIcterbtbFeft04t?=
 =?us-ascii?Q?5tJds7Lfp+iiSgoDjb1Bhn2rN52vUh7npf08CXEHriT+FPHpz2stny3CFm81?=
 =?us-ascii?Q?OA8JT4Jd3AwJCAjla+p64gtG8ZtDND9SYkvcznW45CeYaI7MiRK5QWFP7arc?=
 =?us-ascii?Q?Dfi5zYQjuaotZtKx4T9ARPctcAbAvqfqERYE+qhdtRlnTTO45hny8R/tfPbs?=
 =?us-ascii?Q?6qYJgZev8OOVgTbt3SQSCZe3Yg3Ly85bpQirE2TNrdiH8I0/GTl868iCQhIE?=
 =?us-ascii?Q?1SWjEY1CQU3ll66HgBelVa2dO5Pdawr0qjPcexLHzaBtddIHcNY00w5SMc1j?=
 =?us-ascii?Q?uu1J1ji+EDiaqm1nsBwnU1SOQ1x9MYHSSzJzptOWlOR3H+zBIT7AzoDp65Xu?=
 =?us-ascii?Q?lIFWd8G3GZrvoiJ8oSCBU1IcKcvOOsoE6ihMm/3VE3IBUlK+8YkJmy+kA5JW?=
 =?us-ascii?Q?L/XV9RU25P8U6fOrUNPZPZwDl6Qx2KTQOXCk9OS0h8ZOqtitGvV5EUVjR4hE?=
 =?us-ascii?Q?c8OAzU42OPU/0xvtLqMDKcMl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd37b21-c014-4306-92b1-08d9883fbef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 20:36:01.5943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FyfcUvbr3My6Ok0LfpEpAfNnaoqTQYKoVNjC0nUmyorcVISyvNBby3CmzVnI7lhoqAO9NDGgeOE8qb0WHqOwQxnFpfB/9umwf8uIhtGRBdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1297
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Tuesday, October 5, 2021 =
11:14 AM
>=20
> > > @@ -292,6 +292,9 @@ struct vmstorage_protocol_version {
> > >  #define STORAGE_CHANNEL_REMOVABLE_FLAG		0x1
> > >  #define STORAGE_CHANNEL_EMULATED_IDE_FLAG	0x2
> > >
> > > +/* Lower bound on the size of unsolicited packets with ID of 0 */
> > > +#define VSTOR_MIN_UNSOL_PKT_SIZE		48
> > > +
> >
> > I know you have determined experimentally that Hyper-V sends
> > unsolicited packets with the above length, so the idea is to validate
> > that the guest actually gets packets at least that big.  But I wonder i=
f
> > we should think about this slightly differently.
> >
> > The goal is for the storvsc driver to protect itself against bad or
> > malicious messages from Hyper-V.  For the unsolicited messages, the
> > only field that this storvsc driver needs to access is the
> > vstor_packet->operation field.
>=20
> Eh, this is one piece of information I was looking for...  ;-)

I'm just looking at the code in storvsc_on_receive().   storvsc_on_receive(=
)
itself looks at the "operation" field, but for the REMOVE_DEVICE and
ENUMERATE_BUS operations, you can see that the rest of the vstor_packet
is ignored and is not passed to any called functions.

>=20
>=20
> >So an alternate approach is to set
> > the minimum length as small as possible while ensuring that field is va=
lid.
>=20
> The fact is, I'm not sure how to do it for unsolicited messages.
> Current code ensures/checks !=3D COMPLETE_IO.  Your comment above
> and code audit suggest that we should add a check !=3D FCHBA_DATA.
> I saw ENUMERATE_BUS messages, code only using their "operation".

I'm not completely sure about FCHBA_DATA.  That message does not
seem to be unsolicited, as the guest sends out a message of that type in=20
storvsc_channel_init() using storvsc_execute_vstor_op().  So any received
messages of that type are presumably in response to the guest request,
and will get handled via the test for rqst_id =3D=3D VMBUS_RQST_INIT.  Long=
=20
Li could probably confirm.  So if Hyper-V did send a FCHBA_DATA
packet with rqst_id of 0, it would seem to be appropriate to reject
it.

>=20
> And, again, this is only based on current code/observations...
>=20
> So, maybe you mean something like this (on top of this patch)?

Yes, with a comment to explain what's going on. :-)

>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 349c1071a98d4..8fedac3c7597a 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -292,9 +292,6 @@ struct vmstorage_protocol_version {
>  #define STORAGE_CHANNEL_REMOVABLE_FLAG		0x1
>  #define STORAGE_CHANNEL_EMULATED_IDE_FLAG	0x2
>=20
> -/* Lower bound on the size of unsolicited packets with ID of 0 */
> -#define VSTOR_MIN_UNSOL_PKT_SIZE		48
> -
>  struct vstor_packet {
>  	/* Requested operation type */
>  	enum vstor_packet_operation operation;
> @@ -1291,7 +1288,7 @@ static void storvsc_on_channel_callback(void *conte=
xt)
>  		u32 pktlen =3D hv_pkt_datalen(desc);
>  		u64 rqst_id =3D desc->trans_id;
>  		u32 minlen =3D rqst_id ? sizeof(struct vstor_packet) -
> -			stor_device->vmscsi_size_delta : VSTOR_MIN_UNSOL_PKT_SIZE;
> +			stor_device->vmscsi_size_delta : sizeof(enum vstor_packet_operation);
>=20
>  		if (pktlen < minlen) {
>  			dev_err(&device->device,
> @@ -1315,7 +1312,8 @@ static void storvsc_on_channel_callback(void *conte=
xt)
>  				 * storvsc_on_io_completion() with a guest memory address that is
>  				 * zero if Hyper-V were to construct and send such a bogus packet.
>  				 */
> -				if (packet->operation =3D=3D VSTOR_OPERATION_COMPLETE_IO) {
> +				if (packet->operation =3D=3D VSTOR_OPERATION_COMPLETE_IO ||
> +				    packet->operation =3D=3D VSTOR_OPERATION_FCHBA_DATA) {
>  					dev_err(&device->device, "Invalid packet with ID of 0\n");
>  					continue;
>  				}
>=20
> Thanks,
>   Andrea

