Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97A6532D06
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 May 2022 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbiEXPNK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 May 2022 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiEXPNK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 May 2022 11:13:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89D3F69715
        for <linux-hyperv@vger.kernel.org>; Tue, 24 May 2022 08:13:09 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 43F5420B71D5; Tue, 24 May 2022 08:13:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43F5420B71D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653405189;
        bh=Si1uER1E0OjEJDVIGlI/zNmOmr/Ns0/TxN/F54+SC30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6OQKPYhKGPt75jxcBVoHkL6mCkSDTrVtIV0BNpsGhjhy2xhhwacC9M6eQ2Xr1fl6
         YKtVSwAYwOJdcFw/rqmXIJJFCvyuXK9Uqh/OKTQLLNEdPc3pGikxDzkeunM/GQFfAh
         Th92BjLDxt3Xx2FmUSSiJCqCuMvihx6tfF1gQaLw=
Date:   Tue, 24 May 2022 08:13:09 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3] scsi: storvsc: Removing Pre Win8 related logic
Message-ID: <20220524151309.GA7036@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1653392516-9233-1-git-send-email-ssengar@linux.microsoft.com>
 <DM5PR2101MB1030ED63885693A748892F26CCD79@DM5PR2101MB1030.namprd21.prod.outlook.com>
 <20220524075802.020917e0@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524075802.020917e0@hermes.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 24, 2022 at 07:58:02AM -0700, Stephen Hemminger wrote:
> 
> > 
> > The latest storvsc code has already removed the support for windows 7 and
> > earlier. There is still some code logic reamining which is there to support
> > pre Windows 8 OS. This patch removes these stale logic.
> > This patch majorly does three things :
> > 
> > 1. Removes vmscsi_size_delta and its logic, as the vmscsi_request struct is
> > same for all the OS post windows 8 there is no need of delta.
> > 2. Simplify sense_buffer_size logic, as there is single buffer size for
> > all the post windows 8 OS.
> > 3. Embed the vmscsi_win8_extension structure inside the vmscsi_request,
> > as there is no separate handling required for different OS.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > v3 : Removed pre win8 macros:
> > 	- POST_WIN7_STORVSC_SENSE_BUFFER_SIZE
> > 	- VMSTOR_PROTO_VERSION_WIN6
> > 	- VMSTOR_PROTO_VERSION_WIN7
> > 
> >  drivers/scsi/storvsc_drv.c | 152 ++++++++++---------------------------
> >  1 file changed, 40 insertions(+), 112 deletions(-)
> > 
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index 5585e9d30bbf..66d9adb5487f 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -55,8 +55,6 @@
> >  #define VMSTOR_PROTO_VERSION(MAJOR_, MINOR_)	((((MAJOR_) & 0xff) << 8) | \
> >  						(((MINOR_) & 0xff)))
> >  
> > -#define VMSTOR_PROTO_VERSION_WIN6	VMSTOR_PROTO_VERSION(2, 0)
> > -#define VMSTOR_PROTO_VERSION_WIN7	VMSTOR_PROTO_VERSION(4, 2)
> >  #define VMSTOR_PROTO_VERSION_WIN8	VMSTOR_PROTO_VERSION(5, 1)
> >  #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
> >  #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)
> 
> Keeping the macros is ok, could help with diagnosing some future problem?

[sss] ok

> 
> > @@ -136,19 +134,15 @@ struct hv_fc_wwn_packet {
> >   */
> >  #define STORVSC_MAX_CMD_LEN			0x10
> >  
> > -#define POST_WIN7_STORVSC_SENSE_BUFFER_SIZE	0x14
> > -#define PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE	0x12
> > -
> >  #define STORVSC_SENSE_BUFFER_SIZE		0x14
> >  #define STORVSC_MAX_BUF_LEN_WITH_PADDING	0x14
> >  
> >  /*
> > - * Sense buffer size changed in win8; have a run-time
> > - * variable to track the size we should use.  This value will
> > - * likely change during protocol negotiation but it is valid
> > - * to start by assuming pre-Win8.
> > + * Sense buffer size was differnt pre win8 but those OS are not supported any
> > + * more starting 5.19 kernel. This results in to supporting a single value from
> > + * win8 onwards.
> >   */
> 
> Spelling s/differnt/different/
> Also the wording has become awkward.
> 
> Suggest simpler, shorter comment and make it cons.
> 
> /* Sense buffer size is the same for all versions since Windows 8 */
> static const int sense_buffer_size = STORVSC_SENSE_BUFFER_SIZE;
> 
[sss] will fix
> 
> > -static int sense_buffer_size = PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE;
> > +static int sense_buffer_size = STORVSC_SENSE_BUFFER_SIZE;
> >
