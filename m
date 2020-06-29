Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D519F20E63C
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2020 00:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgF2Vpd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Jun 2020 17:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgF2Shm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::70f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835AAC033C04;
        Mon, 29 Jun 2020 11:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIW0mgVbQ7lznWL2uE+oUU21+PgPrUNG5DdeTaiUUfRzreunXJdWCUb/4CAnIvL5BzhdcRAtuL/2BEpc4sJrCetkicq8LFfZWjDWsYYZVOwRxdJOWYmU0jBR18F3vVWRevxZ765nsUsT4dSEigxnnuGrOT1dOSfFYaY8SAi86uMeZdtfm1seRoQ8q7RbrjbLp4bTHNSBfVBJ+ZJV+qEL6w5Hi3wLobdM9AWa2YiS+quAYN/VtL1VQ5gQf+LCZYbrMLBNp9juX9s2B2l+LiCUiRSzaKkOpoA9iPu1ozQrYREEt1B/HcV1OJPtBDYrK3m9LqaziqCusTTU9QXlpGKoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDVOpS4Zq4PbrFq84IfdgGkud64uuSfF/OuG/y6JjBQ=;
 b=Rywsbns31puqjE8/Ce3L91cMKV8DGJcadlhN294pvZ2IgACLlDW98UaWtaw2W1HWSXr08QQar3dxBNHlXLJdd0p6halE/8rsJXYrT91eTx6FX5040Pl17pAWWZLt1Ur7CS+9yYtN86RAzfLRabXmvgWbBRy/iCH3eN48W1mPDcsR/YTqCrbnMbBZObtRUVElWoh7C+gSVYJT7gPHQCdO1SiXWYEt8QcAlgyoDdH5kW7sju4bS2C3P85G9TWypo44xfXqnNqW0NFPPE+poxpkwzmR6XnWuUqSBDwGeNAnXjY32H9rx7geeICRKGLbLJIim5z/CHHzv8B7mouZVSLiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDVOpS4Zq4PbrFq84IfdgGkud64uuSfF/OuG/y6JjBQ=;
 b=NMbZJxwhiUDi0IdathPc84k3iXQvYKfOOYPqLD/nJMQ2vFwzfclUJHsNuHxj7d5wFJmAcVR6wH8FtkOVDjHV/XYbaF7a5jdoEb785KjX03jqS+zrH+oZyzKDyHPgo8Hh5hC/ttb+9Dw15ZZ8O6mixb7BufDxcGBIvDjTBAxhr2k=
Received: from CH2PR21MB1494.namprd21.prod.outlook.com (2603:10b6:610:88::7)
 by CH2PR21MB1413.namprd21.prod.outlook.com (2603:10b6:610:8c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.1; Mon, 29 Jun
 2020 18:19:46 +0000
Received: from CH2PR21MB1494.namprd21.prod.outlook.com
 ([fe80::38eb:8b9e:8de7:c954]) by CH2PR21MB1494.namprd21.prod.outlook.com
 ([fe80::38eb:8b9e:8de7:c954%7]) with mapi id 15.20.3174.003; Mon, 29 Jun 2020
 18:19:46 +0000
From:   Andres Beltran <t-mabelt@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>, Andres Beltran <lkmlabelt@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>
Subject: Re: [PATCH 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Topic: [PATCH 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Index: AdZOQUsO/cQOS8e4TziUV5xXjrfxNQ==
Date:   Mon, 29 Jun 2020 18:19:46 +0000
Message-ID: <CH2PR21MB149464F9EF20C516C6FB362A8B6E0@CH2PR21MB1494.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [129.22.22.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf10a0cd-0618-45d2-a06e-08d81c590123
x-ms-traffictypediagnostic: CH2PR21MB1413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR21MB14132173B1D3300E766ED0F68B6E0@CH2PR21MB1413.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 14Fgy03NiD7ib4NbWt+PWydkwG9JMFI8i0vgDpQeLyGXxCZLSgNBCZKzhZXLoRaSu653VRGMH2evUAfzVqzl6JYYDV5LU5FS3AKtgSlsjnlgB8QicZbSdgbvacDxGgZnJq7cOd8rGn4o3+N/5bF5ZUdApS14gA3F6PtBvYWo1cK2oHEAe8sYYPwc+O94pndmpkcCgfqjiU0/uhrB3WS5jU7SHx+ubSuqdbtZ+LGO93v9CcfDI685b2yJC6dGqTxk04V6cL2rrxSASqTEZhjfqZjKeDcTvjplq+zR1IZED+7ktZ1HC5XCO1yiEeLCv5mT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1494.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(66446008)(9686003)(64756008)(66556008)(4326008)(478600001)(82950400001)(82960400001)(2906002)(55016002)(86362001)(66476007)(66946007)(76116006)(8676002)(8936002)(26005)(10290500003)(7696005)(33656002)(5660300002)(71200400001)(316002)(110136005)(83380400001)(54906003)(52536014)(6506007)(186003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Psw4uNWZEdO16cUD8rjfLFpgL574dctsiqNSV6LbGIwih1PLpM+3PAZvHjNeBzoyF+tuBLV/jKfMTA4NEuqjlct73Jrs+BY65kyPPA/ZZn20WCUn7WRHOdbDYtLqkYJRsIGEslUMae2IetKKuWgNJ2jaJ5Gkold1CBwsCBESDg74IgQhc1DRIfcjE3eCn9NHB3EmVfspCEMq91JSift0uMKwFW5bzcpDFp8vCF2iUW805efDtTOCKgp3hq9xs+WeVz5yCPON9a2haI0ecvJyXstTplIjuj3n9dXoX1UvjCWohWIk4KYxHVFKWMmTWQlrVfFVhMdtVrzm30JR26rUr1DGAJKfAJ042b1d7IlWqZG+rG+r+r5ve4gZtemUzrEDJb7NSG571rq0uBw+Jg8+qW3RlqbJ6a6iODfq+xTQqdo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1494.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf10a0cd-0618-45d2-a06e-08d81c590123
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 18:19:46.9047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHCFVe+dJ1XvTTvlz0uLdD+eB+ZPcA5d9+SplQylOtZhPXnAyn90meqpVDd25cv2OJQRL5geu9RK+zggmqaLOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1413
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: linux-hyperv-owner@vger.kernel.org <linux-hyperv-owner@vger.kernel.or=
g> On Behalf
Of Wei Liu. Sent: Friday, June 26, 2020 9:20 AM
> >  static int __vmbus_open(struct vmbus_channel *newchannel,
> >  		       void *userdata, u32 userdatalen,
> >  		       void (*onchannelcallback)(void *context), void *context)
> > @@ -122,6 +186,7 @@ static int __vmbus_open(struct vmbus_channel *newch=
annel,
> >  	u32 send_pages, recv_pages;
> >  	unsigned long flags;
> >  	int err;
> > +	int rqstor;
> >
> >  	if (userdatalen > MAX_USER_DEFINED_BYTES)
> >  		return -EINVAL;
> > @@ -132,6 +197,14 @@ static int __vmbus_open(struct vmbus_channel *newc=
hannel,
> >  	if (newchannel->state !=3D CHANNEL_OPEN_STATE)
> >  		return -EINVAL;
> >
> > +	/* Create and init requestor */
> > +	if (newchannel->rqstor_size) {
> > +		rqstor =3D vmbus_alloc_requestor(&newchannel->requestor,
> > +					       newchannel->rqstor_size);
>=20
> You can simply use err here to store the return value or even get rid of
> rqstor by doing

Right. I will do that.

> > @@ -937,3 +1014,75 @@ int vmbus_recvpacket_raw(struct vmbus_channel *ch=
annel, void
> *buffer,
> >  				  buffer_actual_len, requestid, true);
> >  }
> >  EXPORT_SYMBOL_GPL(vmbus_recvpacket_raw);
> > +
> > +/*
> > + * vmbus_next_request_id - Returns a new request id. It is also
> > + * the index at which the guest memory address is stored.
> > + * Uses a spin lock to avoid race conditions.
> > + * @rqstor: Pointer to the requestor struct
> > + * @rqst_add: Guest memory address to be stored in the array
> > + */
> > +u64 vmbus_next_request_id(struct vmbus_requestor *rqstor, u64 rqst_add=
r)
> > +{
> > +	unsigned long flags;
> > +	u64 current_id;
> > +
> > +	spin_lock_irqsave(&rqstor->req_lock, flags);
>=20
> Do you really need the irqsave variant here? I.e. is there really a
> chance this code is reachable from an interrupt handler?

Other VMBus drivers will also need to use this functionality, and
some of them will be called with interrupts disabled. So, I think
we should keep the irqsave variant here.

Andres.

