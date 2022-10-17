Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7520600AB5
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Oct 2022 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJQJao (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Oct 2022 05:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJQJam (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Oct 2022 05:30:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E660F186DC;
        Mon, 17 Oct 2022 02:30:41 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h185so9932157pgc.10;
        Mon, 17 Oct 2022 02:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rM95b+lprcA9+IBLMDF1xffisgCBjIYYF9osRjetg7c=;
        b=ThJ4ieVN61+E41mdaF9bnScV8EbGmdfmwDs+xkIiPqOBjTaOztvpnnLEySALiJrs/q
         OTPi0TaGXbnBgYVYZftNtFDmzAhQdbJhRi/Tc6KPimdkKHJ2QNzUUQ86nuUwEmcK3YiE
         FzBKhYTR5uP1C6IrxVOp3f8q9+o0XzOmpu1yBT3fo9Nw0kgtZdDMTRv5dy6EAcR+C0CX
         W1LRj3hwbKq7py3NJgCiVff7ekY4r5hvmhSi/doSFKD340rE35T6G2cCKGO2i2ZbOiCJ
         9UgvRCDVqq31Gr6YfRrhdEQzgb3rrpiv8Oe+Q2k29recJbt5ZsFwUoa4KiAlfo1uPLhu
         DLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM95b+lprcA9+IBLMDF1xffisgCBjIYYF9osRjetg7c=;
        b=zOdYAcwp0+gDGcZfWK4CU6B10x/C0qAYSaRG3lUulZ1NTjApPMYzGYgpssU7l2ir7J
         Dvh2rgRV6OKY0h9xyajh5H0g82PLF9UmR2JmenglhZ/YaAQCrvlvY8LPBTZBHEPY7hpZ
         j2UXVzg5ckmYg2VaLr+mRVMuHmcLqPaUBG4hlTXL6q2OOMP6TxjaxZkdbhrrRpGTZFRp
         AuLZ4ve+FMy5T688kQmHycWHompsBoLDvWCDOLQn+Jhg8vSMAlzLKpbKGDkfSSVA2vC0
         MMAoL32eNrm33BxvUkdr8oRNbZr5vl6ON/5gZEelkQ9N+S/rmtdiE7NAJUpdTRDYGOVh
         LAvQ==
X-Gm-Message-State: ACrzQf1NE/a1dTc+KQZ2AFv4mO+jW6Cz0dLlCR0pG3VGjruKy3KOSGXB
        h+9t1Xi6w8FXWAkXbJ52SmgpZNRbOqO27A==
X-Google-Smtp-Source: AMsMyM5aRPItposyqZJVKykHnnA3U2YC1YgIJxSjJ57ZAxZxZTi5Tl5HsWTnkwZJ2HnfVOT0VdcjhA==
X-Received: by 2002:a05:6a00:a22:b0:54e:6a90:fbef with SMTP id p34-20020a056a000a2200b0054e6a90fbefmr11555589pfh.53.1665999041347;
        Mon, 17 Oct 2022 02:30:41 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001811a197797sm6105820pll.194.2022.10.17.02.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:30:40 -0700 (PDT)
Date:   Mon, 17 Oct 2022 22:30:33 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jiri Kosina <jikos@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] HID: hyperv: Replace one-element array with
 flexible-array member
Message-ID: <Y00guZiaxDbFaGhX@mail.google.com>
References: <Y00JenqCzKRrcTiF@mail.google.com>
 <CAO-hwJ+q+fsmjKY=BjDazBjUDD3755VhRxWw628=xxC9ePWzqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+q+fsmjKY=BjDazBjUDD3755VhRxWw628=xxC9ePWzqA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 17, 2022 at 10:30:54AM +0200, Benjamin Tissoires wrote:
> On Mon, Oct 17, 2022 at 9:51 AM Paulo Miguel Almeida
> <paulo.miguel.almeida.rodenas@gmail.com> wrote:
> >
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
> 
> FWIW, this is
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
Thanks for reviewing this patch :-)

> > +++ b/drivers/hid/hid-hyperv.c
> > @@ -61,7 +61,7 @@ struct synthhid_msg_hdr {
> >
> >  struct synthhid_msg {
> >         struct synthhid_msg_hdr header;
> > -       char data[1]; /* Enclosed message */
> > +       char data[]; /* Enclosed message */
> >  };
> 
> IMO that struct has no real use. We just use it in
> mousevsc_on_receive() to dereference the first field only, the header.
> So how about we have a followup cleanup patch that just removes it and
> in mousevsc_on_receive() we convert those usages directly to struct
> synthhid_msg_hdr?
> 
> Cheers,
> Benjamin

I'm happy to send a followup cleanup patch for that.

Paulo A.
