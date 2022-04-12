Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34A4FCD76
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Apr 2022 06:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiDLEJv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Apr 2022 00:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiDLEJu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Apr 2022 00:09:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF0902FFCE;
        Mon, 11 Apr 2022 21:07:33 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 682E7205657E; Mon, 11 Apr 2022 21:07:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 682E7205657E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1649736453;
        bh=Ttzy8BQ9PlMSUQQk7cuuFBxQLGJvmjKf1avgoHfG0Jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUgRs7uht0+gzG3Y7HoAoh1/dD5KFCf8VL8+wClpj57ksmFdvagPUCaH2LgiHXSEg
         4OAk2AE3kR8dZ/iCBaEqZWDlCYAalakHpuFMMddeQZ1gFMSF4glhkbqZQ9XACk79hg
         KMenDvoISCAWLu+imtKZNc+DoZrHWZ1zYq/Bputw=
Date:   Mon, 11 Apr 2022 21:07:33 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        "drawat.floss@gmail.com" <drawat.floss@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: Re: [PATCH v3] drm/hyperv: Added error message for fb size greater
 than allocated
Message-ID: <20220412040733.GA6074@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1649650437-17977-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB1270B3CFBE674EB0A7537180BFEA9@BYAPR21MB1270.namprd21.prod.outlook.com>
 <20220411075555.GA15355@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <DM6PR21MB1275F532C58CF5CE7F67D7E8BFEA9@DM6PR21MB1275.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR21MB1275F532C58CF5CE7F67D7E8BFEA9@DM6PR21MB1275.namprd21.prod.outlook.com>
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

On Mon, Apr 11, 2022 at 07:02:19PM +0000, Dexuan Cui wrote:
> > From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> > Sent: Monday, April 11, 2022 12:56 AM
> > > >...
> > > > -	if (fb->pitches[0] * fb->height > hv->fb_size)
> > > > +	if (fb->pitches[0] * fb->height > hv->fb_size) {
> > > > +		drm_err(&hv->dev, "hv->hdev, fb size requested by process %s
> > > > for %d X %d (pitch %d) is greater than allocated size %ld\n",
> > > Should we use drm_err_ratelimited() instead of drm_err()?
> > 
> > The error is not produced in good cases, for every resolution change which is
> > violating this error should print once.
> 
> Thanks for the clarification! Then drm_err() looks good to me.
> 
> > I suggest having it print every time some application tries to violate the policy
> > set at boot time.
> > If we use ratelimit many resolutions error change will be suppressed. Please let
> > me know your thoughts.
>  
> > >
> > > The line exceeds 80 chars.
> > 
> > At first I tried braking the line to respect 80 character boundary, but
> > checkpatch.pl reported it as a problem.
> > And these new lines are suggested by checkpatch.pl itself.
> > Looks the recent rule realted to 80 charachters are changed. Ref :
> > ...
> 
> Good to know! Thanks for sharing the link!
> 
> FYI, the default max_line_length in scripts/checkpatch.pl is 100 now:
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f
> 
> "80-chars" is still preferred, but isn't a hard limit. I also noticed
> "never break user-visible strings such as printk messages ", so yes you're 
> correct. It's perfectly fine to have a not-too-long string that exceeds 80 chars.
> 

Good information ! thank you for digging this.

> > > > +		current->comm, fb->width, fb->height, fb->pitches[0], hv->fb_size);
> > > >  		return -EINVAL;
> > > > +	}
> > >
> > > Maybe we can use the below:
> > > 	drm_err_ratelimited(&hv->dev, "%s: requested %dX%d (pitch %d) "
> > >                      "exceeds fb_size %ld\n",
> > >                      current->comm, fb->width, fb->height,
> > >                      fb->pitches[0], hv->fb_size);
> > >
> > > Note: the first chars of last 3 lines should align with the "&" in the
> > > same column. Please run "scripts/checkpatch.pl" against the patch.
> > 
> > I have tested checkpatch.pl before sending, for the current patch there is no
> > problem from checkpatch.pl
> 
> The line is 138-char long, which seems a little longer to me :-)
> IMO we can make it shorter, e.g. be removing the part "hv->hdev as the
> "drm_err(&hv->dev," already tells us which device it's.

Ok, will make it shorter.

> 
> BTW, if we run the script with --strict, it reports the below:
> 
> # scripts/checkpatch.pl --strict 0001-drm-hyperv-Added-error-message-for-fb-size-greater-t.patch
> CHECK: Alignment should match open parenthesis
> #28: FILE: drivers/gpu/drm/hyperv/hyperv_drm_modeset.c:127:
> +               drm_err(&hv->dev, "hv->hdev, fb size requested by process %s for %d X %d (pitch %d) is greater than allocated size %ld\n",
> +               current->comm, fb->width, fb->height, fb->pitches[0], hv->fb_size);
Sure, will fix this.
