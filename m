Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171A226935D
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 19:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgINRal (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 13:30:41 -0400
Received: from mail-bn8nam12on2092.outbound.protection.outlook.com ([40.107.237.92]:45504
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726250AbgINR3Q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 13:29:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=if7VTnrUWwiE2n/cY3JgGagft7RrVld+sqZSlN95privyzBMIJMCB10XqyKK7F2WrwA/Ix7VDa/YQgzPX9Qf8x+oLdXalxTqCCwy/Ld38VMBUouiNuoxtYHAMYMNDh3GSNhHum+J6mkXuPAgrEllf9ROZAPcwWzdYBWZDV9knwyS7SHIHmdihtPlg1sTNODuoMjIax6eitOl6ug0mgX5I0p8G1vNl5x1nil9ChmDWPnj2ri+wpkOe0yTuGcmCDgKdxGauDXI9MCyjSPe5cbC+nrdptDVIi38BDoSH30g07rhUhgd6br+IcaVHUb1xZ8q/eoVTDrxE2PAm9Kv0BKkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGyMofrWd/RuvOSgAUGffYYdhYlUnHJVjBHjFenv6XE=;
 b=KP9Dspmp7TCd4E7sb0fHBGfN5Zk5jA39bjk45yvD4dbtM8FM0WJC885XlYelE/Xtk9+WabWbSyny9zzuEx6LOYt+DU8IiAtPYOL/NJDqa5x7NRy4AuZFNMFLLRDmxqwbqsIs/EM0nE8Ofcdt9sFTCx/7phiUzuldQkAQo+qg10ngoyw/k2GAmAWUw9ArcYBGBj/HLXSD8tbgr7kUuB1XLztHYf76xsY6+Rvqsry7PzLO6t392xrEBh+50vxe5iy1WxWPklNT0/MBKK1f5n+OkqCw8bacsccGsUMerwCR/gCE740HmIByNWJBNXDcp16vEsL77uynqVDHsela9fWncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGyMofrWd/RuvOSgAUGffYYdhYlUnHJVjBHjFenv6XE=;
 b=gRHWPDKTDfP8Oi/Ps2CyLKESwivxiZ+JL8sxtyPfhw6REE977mC6Q/eOgBwEesJWUPQWU+37Ep1fpugeS/+We+FKSjnMtNQKxTvMjuktrHPCi4u2ORvPmom0VZExMZJW+3R8fEXfaL502/R9r07QQshIYT4MtwsuCXKGixvywaY=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0970.namprd21.prod.outlook.com (2603:10b6:302:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.6; Mon, 14 Sep
 2020 17:29:12 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1%4]) with mapi id 15.20.3412.001; Mon, 14 Sep 2020
 17:29:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Andres Beltran <lkmlabelt@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>
Subject: RE: [PATCH v7 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Topic: [PATCH v7 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Index: AQHWhTK4CcuAC1huL0WTSe45bNSLyqldtpaQgACpd4CACg3pMA==
Date:   Mon, 14 Sep 2020 17:29:11 +0000
Message-ID: <MW2PR2101MB1052FD464D63F86B4DD1BE7BD7230@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200907161920.71460-1-parri.andrea@gmail.com>
 <20200907161920.71460-2-parri.andrea@gmail.com>
 <MW2PR2101MB1052338B4D3B7020A2191EB7D7280@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20200908075216.GA5638@andrea>
In-Reply-To: <20200908075216.GA5638@andrea>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-14T17:29:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c639015d-7cd4-4652-9e49-ebf9b695db6e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98425044-fd5d-4309-6c00-08d858d3b1f2
x-ms-traffictypediagnostic: MW2PR2101MB0970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0970EE7CF937DC31B3E7F660D7230@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VEnLgmZ44tYa2NoodUfTqvMNvsqR+J3u5PkQ01WWjIkMFDexD3OW2e+WR6zGVIA5AQ+IJQBDI2pGqmCTkh54ewX2APJbE/7VLZsPjLk/ExjOkghcwRv57zGWyd1Ps3WM50Y02CrXZLAHRijHvZP4UnkhfL5Kc9k/lqD3lkwXZhW20ja4kFqz8f3LH20+T3OIBrXeVerEAkI3wafb/IecWH4akIOlDjT2ZaGzDWjBLaHQgVegSl91JigHExIHFWuMhieXEzrSp8x5Mv00YIPRWIWoWmU/v4rEqVXOLhJX85FV6Lif5GhO4g9CP88Amt92cNAnxSPLQalix3qF56Jh9rFoEDj0tv42LqzZrw72RfxTZ3Qz09xoS4aP9mp9yAAB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(55016002)(83380400001)(186003)(82960400001)(107886003)(6506007)(66446008)(66946007)(82950400001)(6916009)(66476007)(7696005)(66556008)(86362001)(64756008)(76116006)(8676002)(9686003)(478600001)(8936002)(26005)(52536014)(316002)(10290500003)(2906002)(71200400001)(5660300002)(4326008)(8990500004)(54906003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OhWno/CKG5gHXWsnXee6k2rNA/0HpHVfzuFLOpC4hCZsAq9/gnOm1PriofxodN0LBvOegGOXFXqH6Rb8Iwi2/cgwmSDoGy2CISqzJbC38wl/VYtxhmGxES/2QyzC53f1N0Neg26BJfvEIFUXuXVa+XajdifsEoa0tOuFCelSWixhrKZFISwklhLm56v1JsCDUZS9mEA13OkpDdRquTJyvUDR1ITbaHqMxj+O7sNfm8wINxyZYtsKS9949DuJvmMHUAhZwtT/lNpV/RHEIMh830Iw4ldYFRK7yyuaofKLoqaZikVouBC6WRnFrw/bJbezZRWfABb/0gh4e/9+3iViXKihSr1TNo4KvMOZ51zVClqxHtscO8ePxvK5US9NB+3tedI/ttbxNwYX+FMY64GhNecbvA1K9Zk4NLVywvFFBiU6YrV5HwKh+Q95hs1z8LalkjAZkMmPbCll4DbAoQF3bf/SpvEhe4t4b9+6G+C3BGVt2RsQPvcSRygpYzOc+iR4UDV35Ugy5sd+46Aq7AteYsGS/ywS4zAy5Lnc1GXWeYjQr9XuR0OVzHchW6AMLffHLNmLGMR6My+g0F+pSLFtsVUCCVJzryi+aaeKGNSPU+0utY4y7C9Zlmrt87yLxpMTkdknBi7jywm1j7I+CMFv6g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98425044-fd5d-4309-6c00-08d858d3b1f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 17:29:11.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DT2RxAcByQATLTX61vvjeCvOJDLQA3HkOEpcjH6tbj+/KpDy+FOkOXATWrKYBa90xrihE1x6hhUwpTgerk2W58160mkhuaWdW3szoW0hi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Tuesday, September 8, 202=
0 12:54 AM
>=20
> > > @@ -300,6 +303,22 @@ int hv_ringbuffer_write(struct vmbus_channel *ch=
annel,
> > >  						     kv_list[i].iov_len);
> > >  	}
> > >
> > > +	/*
> > > +	 * Allocate the request ID after the data has been copied into the
> > > +	 * ring buffer.  Once this request ID is allocated, the completion
> > > +	 * path could find the data and free it.
> > > +	 */
> > > +
> > > +	if (desc->flags =3D=3D VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED)=
 {
> > > +		rqst_id =3D vmbus_next_request_id(&channel->requestor, requestid);
> > > +		if (rqst_id =3D=3D VMBUS_RQST_ERROR) {
> > > +			pr_err("No request id available\n");
> > > +			return -EAGAIN;
> > > +		}
> > > +	}
> > > +	desc =3D hv_get_ring_buffer(outring_info) + old_write;
> > > +	desc->trans_id =3D (rqst_id =3D=3D VMBUS_NO_RQSTOR) ? requestid : r=
qst_id;
> > > +
> >
> > This is a nit, but the above would be clearer to me if written like thi=
s:
> >
> > 	flags =3D desc->flags;
> > 	if (flags =3D=3D VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED) {
> > 		rqst_id =3D vmbus_next_request_id(&channel->requestor, requestid);
> > 		if (rqst_id =3D=3D VMBUS_RQST_ERROR) {
> > 			pr_err("No request id available\n");
> > 			return -EAGAIN;
> > 		}
> > 	} else {
> > 		rqst_id =3D requestid;
> > 	}
> > 	desc =3D hv_get_ring_buffer(outring_info) + old_write;
> > 	desc->trans_id =3D rqst_id;
> >
> > The value of the flags field controls what will be used as the value fo=
r the
> > rqst_id.  Having another test to see which value will be used as the tr=
ans_id
> > somehow feels a bit redundant.  And then rqst_id doesn't have to be ini=
tialized.
>=20
> Agreed, will apply in the next version.
>=20

In an offline conversation, Andrea has pointed out that my proposed changes
don't work.  After a second look, I'll agreed that Andrea's code is the bes=
t that
can be done, so my comments can be ignored.

Michael
