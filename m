Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668624E2FE2
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Mar 2022 19:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352114AbiCUSYw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Mar 2022 14:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352100AbiCUSYn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Mar 2022 14:24:43 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11021026.outbound.protection.outlook.com [52.101.57.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258261FA47;
        Mon, 21 Mar 2022 11:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pnz6aHk8UQwUjCviq7hl9+7Ls+LQ82wZ/RYw6gb/7taTRqsjTYxgdf01JJ1LtbmsHDty05HFMHzG3MX/cP9CQNDzLDGFWJgaeCwSLUp+bmMHZ8BHCtsyZ3ZHc+IsWszIGROdughKHSiX4NiG9as/I6F9BZJOL8ED3aXH3+pOqn7foeFoHiagvShE7e70M+SNkO20CNd3r5JrzjIpKLsiQGgJWHw69df9nbenLnUjIKl6L0Iaz3HFR9ReKcL2Wfy3/cZqjTf79GVCfnImCxTSGXewPG1H3yumEeq+lUwiv7G2QtQbOFDljQ2FvI9GQrwXZE1tO5Gys74Ln/bHn54u8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADS0OxzbFozgDkRWq3I0gQsw4rCkUvVW21WP7tTd6Ig=;
 b=nAlfe5mDjl4W1ng4m6dIoUnDLagvfWOUPmRHlrtrTRUVK4qLfhQztoHftVZKHzONO1Y/LB4easTFjujPNa7XQkJiE0C5PEAxakLrfaa4R7139RgQJiylRw4i1KzuVRlFjmvU+ndaUWqfvGtAjDgdNgazGkhb9iKtAJkygkJ68EALTMqh7yuA9f+vLVKu5S0cS+56EMRFm8+F350xaw5uzGxkKBPcYTSlqbc3SSzyWmAsMcfPBWh1/V+EkIUI4RPIVPAp3r7vRq9/9cON84NXE3F2XFn5iaUWMdTVVvPpz23Z1DMYsSn6tYz1Are7YjDoqIYV3iWmh8ErXDhaj6rUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADS0OxzbFozgDkRWq3I0gQsw4rCkUvVW21WP7tTd6Ig=;
 b=VcysiP1LtAaC3l7Vi8DG3mLMehlxJoUHXiq940Dw+ZqkWkbMlUk6gjC1O+QEbypaYqcxd/PmoR2RBqzBBnlqbGr1s9+bzxtN+nz7JGRpeUJTVNpLPLM6Qpv/VI/c+SuWFeO/oPlgfd536b5J9AZUif2mp4nPozPSK58WwfGcuFw=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH0PR21MB1343.namprd21.prod.outlook.com (2603:10b6:510:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.5; Mon, 21 Mar
 2022 18:23:13 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe%4]) with mapi id 15.20.5123.005; Mon, 21 Mar 2022
 18:23:13 +0000
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
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] PCI: hv: Use IDR to generate transaction IDs for
 VMBus hardening
Thread-Topic: [PATCH 1/2] PCI: hv: Use IDR to generate transaction IDs for
 VMBus hardening
Thread-Index: AQHYOvB3U6bIyC7le0ugT4TzjlKbH6zG36LggAGAbICAAZ62gA==
Date:   Mon, 21 Mar 2022 18:23:13 +0000
Message-ID: <PH0PR21MB3025C19EDC8F5230DB1957EBD7169@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220318174848.290621-1-parri.andrea@gmail.com>
 <20220318174848.290621-2-parri.andrea@gmail.com>
 <PH0PR21MB3025016203AAB9AB6ECB6A3ED7149@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220320145833.GA1393@anparri>
In-Reply-To: <20220320145833.GA1393@anparri>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d553f9ca-fdd8-4803-a8ae-062ae5f90bc7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-21T15:42:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60e13e89-f5c3-4eda-4eb5-08da0b67dc68
x-ms-traffictypediagnostic: PH0PR21MB1343:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR21MB13436D4DAE7CC7E20419991BD7169@PH0PR21MB1343.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ogqf3nYn8EbMme5MImHcA/NpW4Y7vW2pq/YkxMHvcgEoGMn8D0VFAB8pnxdqMqVGysCI6O0GGnw8DcTbV76V/czUlWa7ZTDdoYDxciMJ2N4FAu9UeB4sMuHfYXYsZV896QidYOD5BkM1OjoPccX6VTdSiMi/e/z/37C8I7xe9C8Ro0LzNg8n3E2LE7693DR41RVUDGn7GEKQDIiMWzr+jJ/xkiIWGtHcmCOmEoUvyAT54x+LjtVTY2DrKK5tDbGxEzgcNL5IlV2eYrYzTUz4uY9gWjXVn1fXt116sN6OOwhHIe/QIcIfH1mGNPE/7AmmDhRQ+M55uikW5A+X4tTfw2U74Iaxn4SWcFr52LUvVZyMatXJRKzEsi32r4ZrnbwD9Mkqx+XuEIhbQ/2dI1rL26PBBfPcisCkm9jl02XVKKDNaayFDS+PyOwhQvsCz0k5wzOgF4muBjWM4JIsfRMZpoTMx9YAGB1bOagFa3geAtBiJIDKM+E6z9sfHNMtxjRLd2mXPh8Gfkbnp7JNALCTZ2kttGreWlr4xdP0ecdC4F35kB0rri9WtTN9dInyIOdTustjc3FVIqqM8BqxUutqj0uEFW7AqTe+y67pRvYD9UEkx+cCGLCmBf3EH5BnAOTcg6fMz/tOWOQJ4oDttdRX59eQjTcvxIrbXqejyTRb4FpIng1UdxBaZt0L/g+5xPKyODPTcCDLwIBCgRf7ZCc56PWmLNXH8vCgX2+h6qXqfs683opIVNiiajaPhl8NzxuE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(122000001)(5660300002)(33656002)(8936002)(83380400001)(54906003)(316002)(6916009)(38100700002)(55016003)(52536014)(71200400001)(186003)(26005)(38070700005)(82950400001)(9686003)(508600001)(4326008)(64756008)(66946007)(8990500004)(8676002)(2906002)(66446008)(66476007)(66556008)(10290500003)(6506007)(76116006)(86362001)(82960400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CnS3qlrYF+6M0jhNWMJP6Eimb6xiBq18w//rzZ28GeFArYrhdyuuiMVMKB7+?=
 =?us-ascii?Q?ggLaNorybfi5asnXpGu8ecyy9vyGz9tGuOrQwFy8saEocbsxoRXnwifUmD6y?=
 =?us-ascii?Q?K3j8occbNjRXsP6hDJWqNdk2aa1L4eJpNgsyi+sIcw+Xe0vqpjUGMyCcGtjM?=
 =?us-ascii?Q?lgo7lQq821LrRf6V7IupxzKQ3w2wqJUEP8mssX73Yc+i7YDoyEKTSfJr5UrK?=
 =?us-ascii?Q?MX3EhyLPi6oiOjKmTbYmCFavWBuF+t6stspxxfudHZpS1S2AexxD7g+En8Zd?=
 =?us-ascii?Q?nGsY7mDE6LAhFIPXu+eF7/xaXzlz1Qv7sjdWIAIvrvDsl5knb9noh106/FXu?=
 =?us-ascii?Q?JLCLOfGOACgzCQQ12LrxRKa0rT0GqRwQBUrrTEpE1hnfFh1UtsAajVtwEyNW?=
 =?us-ascii?Q?2YAMnK7qs3H3XSyhq84QhdbJqNMfqazLwpo36BbRxQLJBR9qGI2NvXN2R9Jj?=
 =?us-ascii?Q?2SOXN7CK5PvUy/oTX1KbMjg3Dg9eDI/blYqnizaTtl6qE3DYqFTerdjZA1ys?=
 =?us-ascii?Q?FTaFPSMCilC7/RNGFSbqlR44gY2MCoXUwucGNT/CJ2d+kFVkP1jCNmHrsIxU?=
 =?us-ascii?Q?DPw1wPjy6Ca+2iOuyCrbpik4rPXeqW25w3Zwmlt4sDi4bUjxKyRfXyEBLMNi?=
 =?us-ascii?Q?SDtNer2S+wKyLle5LOqpY543kCqJ+mfWt4LAHSxbkb1QnmVeBywvzcoF52Vj?=
 =?us-ascii?Q?HCPtX+vaCqIJnT31ssdJyXSvUObzWRpa7j/tR6BRuVfBYnR1ThIaBM0sAuiO?=
 =?us-ascii?Q?Vl6Dgo1/NC+e0VrBv7ejvZ5/xyYgtbV/D4hBAXLWQZO+ZfGqwnaN8NLVa8ls?=
 =?us-ascii?Q?vUQuiCn4JeNObQ6hqHDpSPEqB3t1sGzAtE2ggTkF1RRHkuIp70/wbtZ3Zcuz?=
 =?us-ascii?Q?ZyckxCMlF68RmQ1iYM24Ad3U4q/AmsDO51uG2UdoIWn1JLNmxO6g1ivt1Gqh?=
 =?us-ascii?Q?L7+HRmB3KA0BxC1vacoaguDx0lNht73dp7p9egBpL7ePsCR81T+cFhl0TaBE?=
 =?us-ascii?Q?aXbgo1SkDJVDW5oV2+u4j8Sks+y5/IMQUaq8qsS9zXWrwPepk6LbMHns4Wfk?=
 =?us-ascii?Q?DjKwmImq+w3qvSBjI45PME9CIH7G00Pc543Ofl4YohA7s7g/Et/WlCSOjFOQ?=
 =?us-ascii?Q?bmNuJlNGCYDPtDnvwcbM2ufLWR+eiJB7fwF28z1JZbWyzyGI/WM+yEzajCMo?=
 =?us-ascii?Q?+k5I8jVdniwA+uD5kGWMc8AhRFGEamlldOYUNWBxQHeNKQtMTLKZ5FKeiwdr?=
 =?us-ascii?Q?fcAFyEe+4b6lephJ55dZZxjKUfGP56DFPulG0VPvWupPieNdguIjte+U9ZPm?=
 =?us-ascii?Q?QHUqqfmS3tRC1F6pmz2xPk7j6llX6wrp2r0kOdLI9RtzN0efO4yR7xh5eL5E?=
 =?us-ascii?Q?WuyT0ItLhETEVSxqFdDnugw3Gx590rj3h1NEUtgycFL6zBc0n/1qDlSVlGm+?=
 =?us-ascii?Q?CmkW5JtREZ0uNIUBrTGNubTIMoZgzvp9fYH2h1JQQEjRyglCE0Av1aHvQnHZ?=
 =?us-ascii?Q?6n7hp2t+gXLY03vQ5oqiLg+c4UHJ28yuPTFQHZqvoVTqcPF9Og26SgSpFYyw?=
 =?us-ascii?Q?3/Rr3wDSD7h4TP/OBvy3bXBBHG3u5UyLqhQzz9hSbrhManKvHzbgRif0jGTY?=
 =?us-ascii?Q?hs7b4mmJDNd/AT9HGuSNsDqZiAdCNn8Be04YDorf8u62yy/LP5TiXIvzcOI6?=
 =?us-ascii?Q?rPxBD4l//bakKBGCEASji59OydV9ZG9ETTT2eq44vGnhnla0eYf8DKGr/NxA?=
 =?us-ascii?Q?hWquphtTid7PYaDEGMNCU2wB9XPmUK4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e13e89-f5c3-4eda-4eb5-08da0b67dc68
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 18:23:13.1771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfWgFrbvQuapijnDJYrZCw62DkN9Th7jSuSr2NjjvXmYGKEs0dAthOxCnzt/sdMV/ljR9K28W0km7BYunEDQrK4eZCCkJDb5JFTJarIVh5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1343
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Sunday, March 20, 2022 7:=
59 AM
>=20
> On Sat, Mar 19, 2022 at 04:20:13PM +0000, Michael Kelley (LINUX) wrote:
> > From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Friday, M=
arch 18,
> 2022 10:49 AM
> > >
> > > Currently, pointers to guest memory are passed to Hyper-V as transact=
ion
> > > IDs in hv_pci.  In the face of errors or malicious behavior in Hyper-=
V,
> > > hv_pci should not expose or trust the transaction IDs returned by
> > > Hyper-V to be valid guest memory addresses.  Instead, use small integ=
ers
> > > generated by IDR as request (transaction) IDs.
> >
> > I had expected that this code would use the next_request_id_callback
> > mechanism because of the race conditions that mechanism solves.  And
> > to protect against a malicious Hyper-V sending a bogus second message
> > with the same requestID, the requestID needs to be freed in the
> > onchannelcallback function as is done with vmbus_request_addr().
>=20
> I think I should elaborate on the design underlying this submission;
> roughly, the present solution diverges from the 'generic' requestor
> mechanism you mentioned above in two main aspects:
>=20
>   A) it 'moves' the ID removal into hv_compose_msi_msg() and other
>      functions,

Right.  A key implication is that this patch allows the completion
function to be called multiple times, if Hyper-V were to be malicious
and send multiple responses with the same requestID.  This is OK as
long as the completion functions are idempotent, which after looking,
I think they are in this driver.

Furthermore, this patch allows the completion function to run anytime
between when the requestID is created and when it is deleted.  This
patch creates the requestID just before calling vmbus_sendpacket(),
which is good.  The requestID is deleted later in the various functions.
I saw only one potential problem, which is in new_pcichild_device(),
where the new hpdev is added to a global list before the requestID is
deleted. There's a window where the completion function could run
and update the probed_bar[] values asynchronously after the hpdev is
on the global list.  I don't know if this is a problem or not, but it could
be prevented by deleting the requestID a little earlier in the function.

>=20
>   B) it adopts some ad-hoc locking scheme in the channel callback.
>=20
> AFAICT, such changes preserve the 'confidentiality' and correctness
> guarantees of the generic approach (modulo the issue discussed here
> with Saurabh).

Yes, I agree, assuming the current functionality of the completion
functions.

>=20
> These changes are justified by the bug/fix discussed in 2/2.  For
> concreteness, consider a solution based on the VMbus requestor as
> reported at the end of this email.
>=20
> AFAICT, this solution can't fix the bug discussed in 2/2.  Moreover
> (and looking back at (A-B)), we observe that:
>=20
>   1) locking in the channel callback is not quite as desired: we'd
>      want a request_addr_callback_nolock() say and 'protected' it
>      together with ->completion_func();

I'm not understanding this point.  Could you clarify?

>=20
>   2) hv_compose_msi_msg() doesn't know the value of the request ID
>      it has allocated (hv_compose_msi_msg() -> vmbus_sendpacket();
>      cf. also remove_request_id() in the current submission).

Agreed.  This would have to be addressed by adding another version of
vmbus_sendpacket() that returns the request ID.

>=20
> Hope this helps clarify the problems at stake, and move forward to a
> 'final' solution...

I think there's a reasonable way for the vmbus_next_request_id()
mechanism to solve the problem in Patch 2/2 (if a new version of
vmbus_sendpacket is added).  To me, that mechanism seems safer
in that it restricts the completion function to running just once
per requestID.  With this patch, we must remember that the
completion functions must remain idempotent.

But I can go either way.  I can give an OK on this solution if that's
the preferred path.  Other input is also welcome ...

Michael

>=20
> Thanks,
>   Andrea
>=20
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index ae0bc2fee4ca8..bd99dd12d367b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -91,6 +91,9 @@ static enum pci_protocol_version_t pci_protocol_version=
s[] =3D {
>  /* space for 32bit serial number as string */
>  #define SLOT_NAME_SIZE 11
>=20
> +/* Size of requestor for VMbus */
> +#define HV_PCI_RQSTOR_SIZE 64
> +
>  /*
>   * Message Types
>   */
> @@ -1407,7 +1410,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpd=
ev,
>  	int_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
>  	int_pkt->int_desc =3D *int_desc;
>  	vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt, sizeof(*int_pkt),
> -			 (unsigned long)&ctxt.pkt, VM_PKT_DATA_INBAND, 0);
> +			 0, VM_PKT_DATA_INBAND, 0);
>  	kfree(int_desc);
>  }
>=20
> @@ -2649,7 +2652,7 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
>  	ejct_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
>  	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
> -			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
> +			 sizeof(*ejct_pkt), 0,
>  			 VM_PKT_DATA_INBAND, 0);
>=20
>  	/* For the get_pcichild() in hv_pci_eject_device() */
> @@ -2696,8 +2699,9 @@ static void hv_pci_onchannelcallback(void *context)
>  	const int packet_size =3D 0x100;
>  	int ret;
>  	struct hv_pcibus_device *hbus =3D context;
> +	struct vmbus_channel *chan =3D hbus->hdev->channel;
>  	u32 bytes_recvd;
> -	u64 req_id;
> +	u64 req_id, req_addr;
>  	struct vmpacket_descriptor *desc;
>  	unsigned char *buffer;
>  	int bufferlen =3D packet_size;
> @@ -2743,11 +2747,13 @@ static void hv_pci_onchannelcallback(void *contex=
t)
>  		switch (desc->type) {
>  		case VM_PKT_COMP:
>=20
> -			/*
> -			 * The host is trusted, and thus it's safe to interpret
> -			 * this transaction ID as a pointer.
> -			 */
> -			comp_packet =3D (struct pci_packet *)req_id;
> +			req_addr =3D chan->request_addr_callback(chan, req_id);
> +			if (!req_addr || req_addr =3D=3D VMBUS_RQST_ERROR) {
> +				dev_warn_ratelimited(&hbus->hdev->device,
> +						     "Invalid request ID\n");
> +				break;
> +			}
> +			comp_packet =3D (struct pci_packet *)req_addr;
>  			response =3D (struct pci_response *)buffer;
>  			comp_packet->completion_func(comp_packet->compl_ctxt,
>  						     response,
> @@ -3419,6 +3425,10 @@ static int hv_pci_probe(struct hv_device *hdev,
>  		goto free_dom;
>  	}
>=20
> +	hdev->channel->next_request_id_callback =3D vmbus_next_request_id;
> +	hdev->channel->request_addr_callback =3D vmbus_request_addr;
> +	hdev->channel->rqstor_size =3D HV_PCI_RQSTOR_SIZE;
> +
>  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0=
,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> @@ -3749,6 +3759,10 @@ static int hv_pci_resume(struct hv_device *hdev)
>=20
>  	hbus->state =3D hv_pcibus_init;
>=20
> +	hdev->channel->next_request_id_callback =3D vmbus_next_request_id;
> +	hdev->channel->request_addr_callback =3D vmbus_request_addr;
> +	hdev->channel->rqstor_size =3D HV_PCI_RQSTOR_SIZE;
> +
>  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0=
,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
