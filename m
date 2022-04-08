Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E114F9BE1
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Apr 2022 19:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiDHRn1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Apr 2022 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiDHRn0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Apr 2022 13:43:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2131.outbound.protection.outlook.com [40.107.237.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EA09230B;
        Fri,  8 Apr 2022 10:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnOIYR+1uTJKU4wHgyt+rL+uuIpr7xxVYDx/armpvUOxY+1hUpNuypGsJrjt9zFFTpeUCtAlJwMGixsaHGuzQ01NdFdWLoR4AqF+ivKiMnirKlv2a66EF3HhQz5w04kUZvr1jflvb10v50KjUEz+c+GiTJyBtmo+w2ZTmsGyAjxi7Q0oSsZR7iyWMfrH/JfkgZRGJLqE9fzBwDoA3VLJ254sIpiy+1rJgLL7spzs6ogjPJ/W0c/vpwxDv9L8bRXJUbBf7YZYU4H/5aYAOdOU15O/5K1pvQRfS6GDA2nm/S+7joDSKCeVPlMh+x30Nwg4exDIVGx/Bu66S59KKA5rgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ETB4VkX3tDttpqfEAFk//OQNaaAa0QTEgXoQHbQfXc=;
 b=grk1z0XweWqkBDenV+mzo2bYqZZhWftRZWWVUGZBRP7iek23AI2C9SztQJNHlaVCJ1KijGmG21cVHKYQ8uSkVd6ArNyUtJEMXu1LEUShUR2aQqXm6IHfPPXyHzo2LCb491MAwrbGYjHsEJejTFO6M2Kj+TXzURbK0oFOhvCVtUShrp2Bt22QThyQKUUMwRJf8cl+DWYAT9Z9m+6V/mvw5npl0fuc7EHDWZQrqoyLd9yOBOu/N2iy888RkHKwT2VPkAFMgbQJNjjlLLveVyzI8J+3V80eL2PCGwEQ5qYGpzh65qEcYjBHGMW9wHBQIEaOo0m9Uv7nxBrqcCHnMS0TGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ETB4VkX3tDttpqfEAFk//OQNaaAa0QTEgXoQHbQfXc=;
 b=HYfWK6CBkazw1IpRoxez/1bYtxp1raPIJGEGVuLoLzhgUyZ8Bh+u/F56VOnXDWE8GePTqX+LN6lgUkyrvLOI8A66GsLOrFkq4EfaswTyU04wQG7ardSOdjBdZWCoVzgh1yBob6+4I0KH4LgRWBu5rSYA5Ak7dkDPqDjIQmc2Zl8=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BY5PR21MB1409.namprd21.prod.outlook.com (2603:10b6:a03:234::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.12; Fri, 8 Apr
 2022 17:41:19 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f%7]) with mapi id 15.20.5164.012; Fri, 8 Apr 2022
 17:41:19 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/6] Drivers: hv: vmbus: Introduce
 vmbus_request_addr_match()
Thread-Topic: [PATCH 4/6] Drivers: hv: vmbus: Introduce
 vmbus_request_addr_match()
Thread-Index: AQHYSjh7yz5y0LU70k+FVkT53LIUc6zmJBNggAAYGICAAAmkYA==
Date:   Fri, 8 Apr 2022 17:41:19 +0000
Message-ID: <PH0PR21MB30258AE4C3CD9674E953C765D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
 <20220407043028.379534-5-parri.andrea@gmail.com>
 <PH0PR21MB3025D745B0F3FA8893B32B39D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220408164717.GA206777@anparri>
In-Reply-To: <20220408164717.GA206777@anparri>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a67653a9-1b50-4938-8cb6-c31d041adf57;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-08T17:21:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d8d119f-ad8e-43a7-bc1e-08da1986fd59
x-ms-traffictypediagnostic: BY5PR21MB1409:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BY5PR21MB1409FFDDF1B75E3557FD5048D7E99@BY5PR21MB1409.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vSVRAgBlPS3fFt3rXHdtlUJ4HY92Lf11NcSPV1H05ecoUDgm0cnbjfI+XlGMkQlcs//DXn++etf3qQ0+/x0ZMVvBMSCYmqLenvyflHBkfMhdiUV3uHWAYHHFR7QXzbpGeTbl9sS18lFeghXGny764MQa1apsN52kEHLF+DRS1Cg7051TJuAXcxx/dg/C/ymjwkJteaKWJ3L4/mThGmOJyzTZPLYDdfDLv8NuMsisXfY34PQ1+ONVD/uiHoAB8u50BrR6rMU7WdeI6YkZ+qItVu+8ku9d0AshoU0rsNgr7Tn7lyo0kZ/4Eaj3PtuXPQVQu6p7Omm0gKQJEB7/8IR90WSE9RRT7n/0x4shtJQvFZ+hpRYs+RsNtQRnq/W6XNDyS5fJY4ksEeQAy0VJLHL+i39FvlTiILjBshtGELkDvMhJltT8tBxlKnlLIwIURVVmUuMx4sdB8cEuxS+eNV3t9p+EWyhSdqVjlg2MRNQiu9C1N7mWALav5EC0s5D7FC1czk1/ETQyul0m8nf1ONvNgL3GpieSXvZtM802smdeJOWL0zduicouvToBrNHSqbm0+jUnkvMfeudoSyqa1iskj7ek6ZWutM/L56mkx2njyd3ghBd4ioYmXxyuIvIdgjglTxTMBCgtNdKB6Dx3Gaseo5CxjVXyOGT1vMqAgI0gm/Eg+idcvLf1rBE1kZ2OqugR+uhLGkzT2LSfEzonXycKApoErOjuVFsWz7YpnBH5OovYrbdjgIwoIcsXt2OruyUb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(33656002)(316002)(54906003)(6916009)(8990500004)(122000001)(8936002)(38100700002)(76116006)(82950400001)(71200400001)(66446008)(66946007)(66476007)(66556008)(64756008)(8676002)(4326008)(86362001)(52536014)(38070700005)(82960400001)(9686003)(7696005)(6506007)(5660300002)(83380400001)(186003)(10290500003)(2906002)(508600001)(26005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BO0mMvL9bcvRK1aVFfsdkfOKbGsWhKzgArMroIB8iB9xo5QK5fOdHzTBtH8I?=
 =?us-ascii?Q?kACbcuA7h71KB+pfT3+WA38vqYBo/daMQK6RROe6vhf9ceQrdwc6KThf/QE5?=
 =?us-ascii?Q?3jxnetMx7rCXiGS8r/sxU9PtrC6k/gxHKcoJNKfaRtitNhRbDG2Ljn/c1k6n?=
 =?us-ascii?Q?FI8EL/tsuEP7wMk54B8KKSDeDgQIa6xrRZAgralt3pu/JTytF7wtEcJw4zjL?=
 =?us-ascii?Q?8ujkzBYwPOiKZAsmv7zb4nopALqsxgpBW3enND60EUxrA6zLwBcp/+jQQdaZ?=
 =?us-ascii?Q?zCyYIK/GyJYWvl3WcYgRfOYh4GMk8v8ZlL9NCnQIbuabeA5YL73I0qf5Ikgp?=
 =?us-ascii?Q?cTS9tctLbu+iMGOe2gGhr1Ur7YJGy7lRf9lTCkERm7Zw395Q57YHdt0EOokU?=
 =?us-ascii?Q?8ZczyzhokK3rmPDD9ja255xjCZOeszYVrBCAisZAcFfMi6nTc+VGygODqaUj?=
 =?us-ascii?Q?PmxKHyslsoxhLtiMZbYUCR427/npfxQ0b5utav0fi++VkIXPIChn0oQv7N8h?=
 =?us-ascii?Q?pdhojEtzdDWWadoS+1bssbtEIj8/akt/GEAObR36VgqbWHcjIruY/MURQP5E?=
 =?us-ascii?Q?WXGnD4T55fNJfxoHM0KUjfuyHvAl6ac12GepKqoovqesMF91Dozwtp8MBpXI?=
 =?us-ascii?Q?CzdG6msRp5u+o9e75mAEFsNG8K92xO5J8uEAg8cYPZmSHJHz8R+IJ7McQ4zH?=
 =?us-ascii?Q?uyGwKAnVGwvqVoEuXLmWFExcuK441bYHBFYoi5yZDWLfmOBBrwanGWsf5aob?=
 =?us-ascii?Q?CsB3extkrUj7tRzsYr7HKGyFzGSJu2DoulGBbavHAOtQ3dbHQZLba9RJOV0e?=
 =?us-ascii?Q?rtUfS4tH5NVVCDdb1NR3sm+Kn3e2/f4bgg0ra1/MRD0CLr3nHz20cJpNXepM?=
 =?us-ascii?Q?WNTgKHaHifVzlNvp6A4nNReE2xBP0tok9+ATCl+J076TkJNodPbGwfYNqrmS?=
 =?us-ascii?Q?WCBpYk8yScltplzgxMs+iCfNIU3PNU38Plk+okoRFmA3I2VD7C/Xx7InB6EP?=
 =?us-ascii?Q?Aa3gq5mlAdb07QYwM9Wd9FFp9q8NM+vX1V+/aywngCH5nG+DabR/We5u8CPB?=
 =?us-ascii?Q?mYcyQ7YBcUncWj3FQe8kCY8Yj+QmCVK1m3m9kaRufK5yqykL1mNqiVS2Fo5x?=
 =?us-ascii?Q?x3JMbJQ2eb5ys3E0cTmR9oybpJlIcMvWHK+3opusk4zRcsEQaI09jF6gnkaG?=
 =?us-ascii?Q?FvE9/RItcuPtXKQS6i04kmyn7/h4w3ZHRj8WhzXarCrCMEONwLWOMWEH/8fU?=
 =?us-ascii?Q?hM7BgVmuZV7pp/Pzit2EJz2tLytvO62D2blzG2c7wWGJgiflLiYLBRubU51d?=
 =?us-ascii?Q?XYhkZqDlS2wn19GGT55yWeEWz0GgbIkIAfWwFpc9Blka6o2T58IuuAbjrrZW?=
 =?us-ascii?Q?CAQFeJeLiDin/yvVoUCzxV3Dbxw/CBAUXh+CS9DR/F2K3s+Vj2WcCZzasCDz?=
 =?us-ascii?Q?J5xFfz6wxkSG7ATCqcw5RFh9CGJK/mvk74mCVQqPIw/oaD1rOArssPAtjMAL?=
 =?us-ascii?Q?+WiCSmUZkK1KoJQIu98dxGb2dqjZcqjL6EdHD8M6/wWBPuv7jtwi0jOGskuq?=
 =?us-ascii?Q?4ejr+LmLFEuMiTixtoUsErmNas8wfMyKQCiA+jkFUut3HNCKml5GpmvzI7kG?=
 =?us-ascii?Q?WnUbQea3CzcTzIfeQzPiwuWIClVH14Fa6+bgy77VoYPfoXc7NWXKCONK5owa?=
 =?us-ascii?Q?VewT0TXNtAlunfYHN168zibBbdhT78uqaPAB2778erjwvEJa31JICNnveB4L?=
 =?us-ascii?Q?GwbOZ20ZUa/fDweqd+4a5NiR8Kfvn6Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8d119f-ad8e-43a7-bc1e-08da1986fd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 17:41:19.1024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4QfX18Yz9iLs8KmqzBrEpP7V+Dd4nd++3XY2fDvX/BL2dH5JWnpOc/EjbCBjxC0Ng7+bU1KRt6XFJ158xxt/A1ipRYLiWNIRVdI8a52Zw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1409
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Friday, April 8, 2022 9:4=
7 AM
>=20
> > > @@ -1300,25 +1294,60 @@ u64 vmbus_request_addr(struct vmbus_channel
> > > *channel, u64 trans_id)
> > >  	if (!trans_id)
> > >  		return VMBUS_RQST_ERROR;
> > >
> > > -	spin_lock_irqsave(&rqstor->req_lock, flags);
> > > -
> > >  	/* Data corresponding to trans_id is stored at trans_id - 1 */
> > >  	trans_id--;
> > >
> > >  	/* Invalid trans_id */
> > > -	if (trans_id >=3D rqstor->size || !test_bit(trans_id, rqstor->req_b=
itmap)) {
> > > -		spin_unlock_irqrestore(&rqstor->req_lock, flags);
> > > +	if (trans_id >=3D rqstor->size || !test_bit(trans_id, rqstor->req_b=
itmap))
> > >  		return VMBUS_RQST_ERROR;
> > > -	}
> > >
> > >  	req_addr =3D rqstor->req_arr[trans_id];
> > > -	rqstor->req_arr[trans_id] =3D rqstor->next_request_id;
> > > -	rqstor->next_request_id =3D trans_id;
> > > +	if (rqst_addr =3D=3D VMBUS_RQST_ADDR_ANY || req_addr =3D=3D rqst_ad=
dr) {
> > > +		rqstor->req_arr[trans_id] =3D rqstor->next_request_id;
> > > +		rqstor->next_request_id =3D trans_id;
> > >
> > > -	/* The already held spin lock provides atomicity */
> > > -	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
> > > +		/* The already held spin lock provides atomicity */
> > > +		bitmap_clear(rqstor->req_bitmap, trans_id, 1);
> > > +	}
> >
> > In the case where a specific match is required, and trans_id is
> > valid but the addr's do not match, it looks like this function will
> > return the addr that didn't match, without removing the entry.
>=20
> Yes, that is consistent with the description on vmbus_request_addr_match(=
):
>=20
>   Returns the memory address stored at @trans_id, or VMBUS_RQST_ERROR if
>   @trans_id is not contained in the requestor.
>=20
>=20
> > Shouldn't it return VMBUS_RQST_ERROR in that case?
>=20
> Can certainly be done, although I'm not sure to follow your concerns.  Ca=
n
> you elaborate?
>=20

Having the function return "success" when it failed to match is unexpected
for me.  There's only one invocation where we care about matching
(in hv_compose_msi_msg).  In that invocation the purpose for matching is to
not remove the wrong entry, and the return value is ignored.  So I think
it all works correctly.

Just thinking out loud, maybe vmbus_request_addr_match() should be
renamed to vmbus_request_addr_remove(), and not have a return value?
That would be a bit more consistent with the actual purpose.

Michael


