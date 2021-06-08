Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1339F983
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jun 2021 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhFHOul (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Jun 2021 10:50:41 -0400
Received: from mail-co1nam11on2139.outbound.protection.outlook.com ([40.107.220.139]:51681
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233560AbhFHOuk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Jun 2021 10:50:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VI7JOlyjbECqXm7nZuuj1EjRzIePjcbPR1bTANxTxZQCK0OoG+k3sJ35OjS+VAhAeyizajtTnQzTLsdqM9wlVJUtI89LKSrVOj/V9qAT/Nz1CLcCB9Fg23AzaYbD467alcAYseUDy2wpekKlW8vTbb/dwSUcTPoxhGTABRaRBP5B0VzzgchSrOEhR4GFfNS4TUCnzYFX8mJwv+zKfvTJbC5XnqtLmFvSlEXZQu1sRZgGuyKYvaM6z+RXexQOpH7LaDxlllnKH5+g8JpX9BkxJ/ESyUILF6Va0ahSexSXIxIKTihNCSEdY3rQB7BRNsevS9MR46dMGucRbx+rFwET5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujHDmpnRJ4/cY0bK3E5ScTYXf3wUx9kVDv4fxAL7qqw=;
 b=FyXI6fdPhVKeup0yFyq3JBITINgEMbXSbSVXXpmX0ddBaABi3DoNjdySpOD3QH0iBO509DA/ru/6MA61/kDAW3nBcniyMIxGoaiJUSCZXUQbdRzirjpg0R3DRzxLs9ZyzhyR/M3ezurH29Dg9+j35Z7s+fhgTDZaGxO7yeiSxDRmU+M/n2vPoGOsutoBFRguw8f8bNnXncN53aD4qpm+HDwZl0Oc+A+CtvWracGFPEakVi03C/H996AMH/lEXd6i4pRub18TMFkk8GAFlixo4p8qoHGc/2Zl8wm5QaOcYXdc4xiPDHHf4vpn28aZUTrmkR0fmd0SPIHOl648fLy6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujHDmpnRJ4/cY0bK3E5ScTYXf3wUx9kVDv4fxAL7qqw=;
 b=h8R2u2r6vg1q2FtWihfSdF+NWaoCu8hrgMh2UQ8wjnFsah34g2S5NyU7P4NnZ/wV8rsK++9eDTBDs1mHKi0qr6Nt6J6BjwJ6AIxYZrdgL4lyh7C+cGgGGv7gaMyj9kms74ikSskNAqnB8S8fcV/gcY7DLM60yTSUigL/hKLo8/s=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0940.namprd21.prod.outlook.com (2603:10b6:302:4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.5; Tue, 8 Jun
 2021 14:48:44 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dbd:8360:af6:b8a2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dbd:8360:af6:b8a2%9]) with mapi id 15.20.4242.007; Tue, 8 Jun 2021
 14:48:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 3/3] scsi: storvsc: Correctly handle multiple flags in
 srb_status
Thread-Topic: [PATCH 3/3] scsi: storvsc: Correctly handle multiple flags in
 srb_status
Thread-Index: AQHXWWYJfm7T4x/P7ECmgJNN1E96wasJJSuAgAEQpHA=
Date:   Tue, 8 Jun 2021 14:48:44 +0000
Message-ID: <MWHPR21MB159382417618D56A90F70E5BD7379@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
 <1622827263-12516-3-git-send-email-mikelley@microsoft.com>
 <BY5PR21MB1506CA56A8470892FA0952A9CE389@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB1506CA56A8470892FA0952A9CE389@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4cc0d189-a83b-498e-88ab-ea7c01acc869;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-07T22:05:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11b1fd26-7176-4eb5-fa0c-08d92a8c83ad
x-ms-traffictypediagnostic: MW2PR2101MB0940:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0940AFC1F278AAD5259BBDBAD7379@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4N26jeFbHOyBRPZ60afsr/s+/F7AQXzoyFUH5OaLmGsTKKerHI84S2HHqRtpku/DpU0EML3Ugr98aOntG7u6bWY+KDISrYY3bb974zxRipsI4fWxj3pwlYVcDJ1Ox3DBWeR+PzxdNDGOb1zfTgDjXGdk15G413FPMEy876e0Qr6Ps7CFNVuqIIR4RWstqb0h10emJL6vwB9iAm4AM0vZn+PWxf56Y7HYunuRaIvJjLnFVbgn8HxSB53VhQUPGyraLl1UyXVYq0a2oR0tqn9Zh+q7lb/szbgmMRR+yoveMD0xDqhH+zFP2mXzlaDi3xv4MZZMsgIeKizP90lNLv9YnbjishBHaZsoowhyoOa6zH6Mw0Cx1ThHfWF3nzq7e0pE2MHw4tu5Z+0t19oi6j3GrNIeYIrJdQ4l2dxx1dPJ5tcWyK5Fz/n7Rw1cJvuFWjx0m0YRyPXPJvOjioMDgLKx/kPSbEQv9lr6EbzKOzZ3MBCv+oLkNTIHemelQCdGAhrsxGGx/0af1i4B3AeVpw4e0lZRTU1gGxkhtMRjBvbG0DOMXFGJSQkwqOyrTzTwrEL4vxJ2p5InS2EUN8Ff0suJ5xNZmWb7bNirl37yy7SUys/yI2eyLYz+GJV5uDY5ZsBpdbWp+U7sIUOytLzi1OKiOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(10290500003)(186003)(8676002)(38100700002)(26005)(5660300002)(6506007)(76116006)(66446008)(122000001)(9686003)(64756008)(86362001)(66556008)(71200400001)(66946007)(52536014)(66476007)(55016002)(82950400001)(82960400001)(8990500004)(2906002)(83380400001)(110136005)(7696005)(498600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m+n9dRDaNKFWb+AdSOVv/B4mdFIfywmiDSJy8XbmGAlC3uL23KE4SibKw7+T?=
 =?us-ascii?Q?Dfa2bWRF94ht7fgBO0wVzdZPeOgCvpu8Adsf5b+F7l9yjBD3obiUQ1vg7+gD?=
 =?us-ascii?Q?+EXIjkbQCDOb9HVgnc+ZTfhQiXRsBHNc8WdfEO4DBzhgiUwR0ZsGXZoHOH29?=
 =?us-ascii?Q?xD74DKlhCAae4NF0PNt1dNLpOEpWLHUpvXs27TW5tItXQWzffVCCOCxssAso?=
 =?us-ascii?Q?67ynnLsKRqtzjaHxiXSpxCviy8OBDZc4j3qMaongx5Lrvavz3C5G4W1oo6TF?=
 =?us-ascii?Q?RjFmGBo6d8/ZJtIIkHvC75t7NfpRy3H24dgFf8+qiV/Q//dRtBWAOUL02PRJ?=
 =?us-ascii?Q?WrifOqkwOsg2fKOPiV8xdK/K5Y7knqB1p9iUwbZQcrNlQ/OMDt3E9v1lFvm0?=
 =?us-ascii?Q?y2RZHPOfZ8novuPdYB7pC3EBy2grGSuIjMkRrTQ97ic7A9D4BQ+Uc1bWzkbU?=
 =?us-ascii?Q?eFANZ0gbnP4GsCKWz8zLBIP2ZmRAVdK0ALgnFI3BUKcJ79VO7tNZ3IIzeODd?=
 =?us-ascii?Q?tRrHnb+JpPfWJ++spJjdMEc9mSfOkTgxpNbbtl0SNMI31y4J/CJ2kzyYWyiH?=
 =?us-ascii?Q?k2Z9GZmUJwhdcsLPpIZ/qzW/Fvs9MPK3lNDYcErqlMmlnHQJNAq0/qruvZy1?=
 =?us-ascii?Q?h3vwclwJ+/8dPqhlVb3YAFLQg0Eh6FRwOgxCcZcHmQWikBQsywIssD3nDtZf?=
 =?us-ascii?Q?UE1n7wzdPY+cUuaCN5J6kcP/iXL0zXYIz1f9WLu/ZbA7TQNYKYvjy+LU6070?=
 =?us-ascii?Q?hKCxR5ZJsIkOxNY+IVxjrWPOFnlnSFEkjbsXo7lgo74HC48xDtflukD0S2kR?=
 =?us-ascii?Q?qbQCqeQ0wj5+KG/lEhLi7BBgHj5/7aUz7c+CeHL1zqIzRBwNTbq4OvhijmoI?=
 =?us-ascii?Q?b0qSN129Ep8kgUJ5FpiYiXUq1rWIwB4Y8NtjtWTq4KZc6X+Bwgm8yvfZrq0R?=
 =?us-ascii?Q?mmb9SEt1F7361ssiv/pkLtTRaCdo3dFptfPGVOXLKSHgGGuyZWXdTUi5UYY1?=
 =?us-ascii?Q?ZOriE0MdDF2uyaRHtDXGt8SJHvNj9kf0d5jkGmdzvdBzBskr/2GZXDBKwDYN?=
 =?us-ascii?Q?XsQYjCN0G1pOjtru12yG3cs8CgalTmnGZVtQxdKN5+vUUc3YH9mooe1JFIc1?=
 =?us-ascii?Q?lpMflGdjtRcL5Qyby+CSksFjmMjl7gdsaIzCj5EVXitxgB3N9piBJspNtUCV?=
 =?us-ascii?Q?JZQ3rBh90zn8d2tl754oZmsXvTm9wGVdCb/PZOOm6Y5qGwP1zLyd2VI27k0F?=
 =?us-ascii?Q?x739vyCip4hqsfBj0FRnL/dn+8l85wjDe9osm2IAfXfQYEqkWWkJzmNHASS9?=
 =?us-ascii?Q?jj2/m7mkRFjb58Vw0kg9D++p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b1fd26-7176-4eb5-fa0c-08d92a8c83ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 14:48:44.2021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdBk9eDmDwtSQINRs43ewz8LQtT2ham4Zl7UnNNPggSDSKGm7+QyU9oCklQr3Qj0xYPPzHS9Fbflr4nSuZe3zHZw+wsaeUbSE0Hii0FmvmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Monday, June 7, 2021 3:25 PM
> >
> > Hyper-V is observed to sometimes set multiple flags in the srb_status, =
such
> > as ABORTED and ERROR. Current code in
> > storvsc_handle_error() handles only a single flag being set, and does n=
othing
> > when multiple flags are set.  Fix this by changing the case statement i=
nto a
> > series of "if" statements testing individual flags. The functionality f=
or handling
> > each flag is unchanged.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 61 +++++++++++++++++++++++++-------------=
---
> > -----
> >  1 file changed, 33 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c in=
dex
> > fff9441..e96d2aa 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -1009,17 +1009,40 @@ static void storvsc_handle_error(struct
> > vmscsi_request *vm_srb,
> >  	struct storvsc_scan_work *wrk;
> >  	void (*process_err_fn)(struct work_struct *work);
> >  	struct hv_host_device *host_dev =3D shost_priv(host);
> > -	bool do_work =3D false;
> >
> > -	switch (SRB_STATUS(vm_srb->srb_status)) {
> > -	case SRB_STATUS_ERROR:
> > +	/*
> > +	 * In some situations, Hyper-V sets multiple bits in the
> > +	 * srb_status, such as ABORTED and ERROR. So process them
> > +	 * individually, with the most specific bits first.
> > +	 */
> > +
> > +	if (vm_srb->srb_status & SRB_STATUS_INVALID_LUN) {
> > +		set_host_byte(scmnd, DID_NO_CONNECT);
> > +		process_err_fn =3D storvsc_remove_lun;
> > +		goto do_work;
> > +	}
> > +
> > +	if (vm_srb->srb_status & SRB_STATUS_ABORTED) {
> > +		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID &&
> > +		    /* Capacity data has changed */
> > +		    (asc =3D=3D 0x2a) && (ascq =3D=3D 0x9)) {
> > +			process_err_fn =3D storvsc_device_scan;
> > +			/*
> > +			 * Retry the I/O that triggered this.
> > +			 */
> > +			set_host_byte(scmnd, DID_REQUEUE);
> > +			goto do_work;
> > +		}
> > +	}
> > +
> > +	if (vm_srb->srb_status & SRB_STATUS_ERROR) {
>=20
> I'm curious on SRB_STATUS_INVALID_LUN and SRB_STATUS_ABORTED, the actions=
 on
> those two codes are different.
>=20
> It doesn't look like we can get those two in the same status code.

Agreed.  I've only observed having ERROR and ABORTED in the same status cod=
e.
That happens when a bad PFN is passed on a I/O request, which can be easily
tested.  With the old code, having ERROR and ABORTED together resulted in d=
oing
nothing.

The behavior of INVALID_LUN is unchanged by this patch.  But with this patc=
h,
if INVALID_LUN and ABORTED should ever occur together, we would process the
INVALID_LUN error, and ignore ABORTED, which I think makes sense.=20
INVALID_LUN is the most serious error, so we process it first.  Then ABORTE=
D is
next in priority for the specific case of "Capacity data has changed".  Fin=
ally we
handle ERROR.

Michael

>=20
> >  		/*
> >  		 * Let upper layer deal with error when
> >  		 * sense message is present.
> >  		 */
> > -
> >  		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID)
> > -			break;
> > +			return;
> > +
> >  		/*
> >  		 * If there is an error; offline the device since all
> >  		 * error recovery strategies would have already been @@ -
> > 1032,37 +1055,19 @@ static void storvsc_handle_error(struct vmscsi_requ=
est *vm_srb,
> >  			set_host_byte(scmnd, DID_PASSTHROUGH);
> >  			break;
> >  		/*
> > -		 * On Some Windows hosts TEST_UNIT_READY command can
> > return
> > -		 * SRB_STATUS_ERROR, let the upper level code deal with it
> > -		 * based on the sense information.
> > +		 * On some Hyper-V hosts TEST_UNIT_READY command can
> > +		 * return SRB_STATUS_ERROR. Let the upper level code
> > +		 * deal with it based on the sense information.
> >  		 */
> >  		case TEST_UNIT_READY:
> >  			break;
> >  		default:
> >  			set_host_byte(scmnd, DID_ERROR);
> >  		}
> > -		break;
> > -	case SRB_STATUS_INVALID_LUN:
> > -		set_host_byte(scmnd, DID_NO_CONNECT);
> > -		do_work =3D true;
> > -		process_err_fn =3D storvsc_remove_lun;
> > -		break;
> > -	case SRB_STATUS_ABORTED:
> > -		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID &&
> > -		    (asc =3D=3D 0x2a) && (ascq =3D=3D 0x9)) {
> > -			do_work =3D true;
> > -			process_err_fn =3D storvsc_device_scan;
> > -			/*
> > -			 * Retry the I/O that triggered this.
> > -			 */
> > -			set_host_byte(scmnd, DID_REQUEUE);
> > -		}
> > -		break;
> >  	}
> > +	return;
> >
> > -	if (!do_work)
> > -		return;
> > -
> > +do_work:
> >  	/*
> >  	 * We need to schedule work to process this error; schedule it.
> >  	 */
> > --
> > 1.8.3.1

