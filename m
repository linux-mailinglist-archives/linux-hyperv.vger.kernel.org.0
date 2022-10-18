Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43811602C39
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Oct 2022 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJRM4c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Oct 2022 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJRM4b (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Oct 2022 08:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAE9733FD;
        Tue, 18 Oct 2022 05:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E4136153F;
        Tue, 18 Oct 2022 12:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15559C433C1;
        Tue, 18 Oct 2022 12:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666097786;
        bh=/vHNygegziKCA4VNx1TW5Fmp5dKqLbj1UZYsAAqZAeo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=EtZTt+G9DOU4CSgbn8arUlALvx79zUkfj+olr5bhKDXDfLPy1T06DiJOymCNdQ7JY
         WSveE5OEC5STK4QoCWaVtx6k/E0FWgfnmjXml0P3PGMGK0zuNEMQUnUmtyE3UsBLEL
         TT+rlXUo3QFn5Nh8XZnybCd8KH5R27cUVTgnMdilHJnPuL2ALn66OUEsQfZu4JTsZT
         C5NhvNOCkEVrLIFyzXCbpg2qXemLTar1JzAIp9pHA9pcEvZTfvYddRwkjV2+hcC3nY
         86AtVLZDtyA2jTTeMP7rUkM5eSWYiSmkGhlF/UwEoTqrBfMnJdPMXFYFMmS0a1JS1I
         jO3Azr+4B1y9A==
Date:   Tue, 18 Oct 2022 14:56:21 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] [next] HID: hyperv: Replace one-element array with
 flexible-array member
In-Reply-To: <SN6PR2101MB1693AFDA151C35DE148FECAAD7299@SN6PR2101MB1693.namprd21.prod.outlook.com>
Message-ID: <nycvar.YFH.7.76.2210181456150.29912@cbobk.fhfr.pm>
References: <Y00JenqCzKRrcTiF@mail.google.com> <SN6PR2101MB1693AFDA151C35DE148FECAAD7299@SN6PR2101MB1693.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 17 Oct 2022, Michael Kelley (LINUX) wrote:

> > One-element arrays are deprecated, and we are replacing them with
> > flexible array members instead. So, replace one-element array with
> > flexible-array member in structs synthhid_msg, synthhid_input_report,
> > pipe_prt_msg and refactor the rest of the code accordingly.
> > 
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> > 
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://github.com/KSPP/linux/issues/210
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> > 
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
> >  drivers/hid/hid-hyperv.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> > index e0bc73124196..208cf8d981a5 100644
> > --- a/drivers/hid/hid-hyperv.c
> > +++ b/drivers/hid/hid-hyperv.c
> > @@ -61,7 +61,7 @@ struct synthhid_msg_hdr {
> > 
> >  struct synthhid_msg {
> >  	struct synthhid_msg_hdr header;
> > -	char data[1]; /* Enclosed message */
> > +	char data[]; /* Enclosed message */
> >  };
> > 
> >  union synthhid_version {
> > @@ -99,7 +99,7 @@ struct synthhid_device_info_ack {
> > 
> >  struct synthhid_input_report {
> >  	struct synthhid_msg_hdr header;
> > -	char buffer[1];
> > +	char buffer[];
> >  };
> > 
> >  #pragma pack(pop)
> > @@ -118,7 +118,7 @@ enum pipe_prot_msg_type {
> >  struct pipe_prt_msg {
> >  	enum pipe_prot_msg_type type;
> >  	u32 size;
> > -	char data[1];
> > +	char data[];
> >  };
> > 
> >  struct  mousevsc_prt_msg {
> > @@ -232,7 +232,7 @@ static void mousevsc_on_receive_device_info(struct
> > mousevsc_dev *input_device,
> > 
> >  	ret = vmbus_sendpacket(input_device->device->channel,
> >  			&ack,
> > -			sizeof(struct pipe_prt_msg) - sizeof(unsigned char) +
> > +			sizeof(struct pipe_prt_msg) +
> >  			sizeof(struct synthhid_device_info_ack),
> >  			(unsigned long)&ack,
> >  			VM_PKT_DATA_INBAND,
> > @@ -271,16 +271,14 @@ static void mousevsc_on_receive(struct hv_device *device,
> >  		 * malicious/buggy hypervisor/host, add a check here to
> >  		 * ensure we don't corrupt memory.
> >  		 */
> > -		if ((pipe_msg->size + sizeof(struct pipe_prt_msg)
> > -			- sizeof(unsigned char))
> > +		if (struct_size(pipe_msg, data, pipe_msg->size)
> >  			> sizeof(struct mousevsc_prt_msg)) {
> >  			WARN_ON(1);
> >  			break;
> >  		}
> > 
> >  		memcpy(&input_dev->protocol_resp, pipe_msg,
> > -		       pipe_msg->size + sizeof(struct pipe_prt_msg) -
> > -		       sizeof(unsigned char));
> > +				struct_size(pipe_msg, data, pipe_msg->size));
> >  		complete(&input_dev->wait_event);
> >  		break;
> > 
> > @@ -359,8 +357,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
> >  	request->request.version_requested.version = SYNTHHID_INPUT_VERSION;
> > 
> >  	ret = vmbus_sendpacket(device->channel, request,
> > -				sizeof(struct pipe_prt_msg) -
> > -				sizeof(unsigned char) +
> > +				sizeof(struct pipe_prt_msg) +
> >  				sizeof(struct synthhid_protocol_request),
> >  				(unsigned long)request,
> >  				VM_PKT_DATA_INBAND,
> > --
> > 2.37.3
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thanks, applied.

-- 
Jiri Kosina
SUSE Labs

