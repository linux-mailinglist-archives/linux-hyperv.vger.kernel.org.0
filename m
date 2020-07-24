Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4822D20C
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Jul 2020 01:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgGXXEj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 24 Jul 2020 19:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgGXXEj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 Jul 2020 19:04:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02599C0619D3;
        Fri, 24 Jul 2020 16:04:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p1so5387828pls.4;
        Fri, 24 Jul 2020 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viZb3dP6geDF5PURTYvDmlf2wCQUcIL8mMEXCiYeHMg=;
        b=bZ+LwkvWNxLJKSe5Xbe7GFCWoRJk0DvL/BQdw4lPKW7w35GCunmmRXG9gFcbKbGlhj
         wAefg0H+eHbHNlOy+Kcfm4Ilsjyl+uZGhBWE1TZ5rZ8Wn7WPRVEJwWiYP1X8EAWlksmv
         sqdSo3LIoKnpAlCbuhx6t1hX2YXteItPzysuZmuofCba6xfoQvQEEw6o7Poe4xXpWHJi
         Yde5nNfp4HkN1VGxToHfRbkOdflNgi5qTtKvzpuIIgWegJeKMjQ67glBtXBcvq57kDKH
         TwNdYXmS13k8vWsEXBHua6mc+1cPHc+TQ6TLMid6g0wINoeJ2GjfoKPf1evlDQYxCyMf
         KavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viZb3dP6geDF5PURTYvDmlf2wCQUcIL8mMEXCiYeHMg=;
        b=aYAYLAJLmg4JSHCAzF2TcdU0O1i2CeW5apmnesqc5bGjbVztzZ4Qcul4ba8+F2iJAU
         QihBoZNWkfYfX7C06suHAn6Bh78SWjOa22hgYkUzpcXSjgFXXvZC+s+f/8Yoy9uPZqf+
         ppyahtsj6XXQ+GjIo4ILTi18bYuxXHVVZS+6Uq7NmzvA2fdF5+vN7mHmKC4GkwC+Grzv
         HGi5PH+yDBl6FNo7UJLViQxKEbM8I1LmstaJA75zKxjEtMGJk7NqA3RWDBEETzygBMB3
         ufucLQVFaWR1W/liK/JW3PfxsLoa1RCQM4ekM6aq3Bt8e0dyxkXYKWLKhfZo2+NcXTF9
         /Cdg==
X-Gm-Message-State: AOAM5324x7tSt7L8cL+Q/fdVkhA/Nhnp1pfgfIr+Iir3O5BA72blpW6P
        J81M+fqd/8jG0i37z+/7apuZfSDC/C2JyH3Ncw8=
X-Google-Smtp-Source: ABdhPJyc1gV36DEfDbuWmuPOnYjENlVAWiB9XdB9wwOWnhnCUDyHqS1gIvuAEtEHEYIoabTXO0jzcKu36u5GGIaMNOw=
X-Received: by 2002:a17:90a:6acb:: with SMTP id b11mr7489368pjm.71.1595631878392;
 Fri, 24 Jul 2020 16:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200724164606.43699-1-lkmlabelt@gmail.com> <20200724101047.34de7e49@hermes.lan>
In-Reply-To: <20200724101047.34de7e49@hermes.lan>
From:   Andres Beltran <lkmlabelt@gmail.com>
Date:   Fri, 24 Jul 2020 19:04:27 -0400
Message-ID: <CAGpZZ6ugh-SprR=oMkktEVuEJvNrK06TLqgskey0JkCdZCmvMA@mail.gmail.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix variable assignments in hv_ringbuffer_read()
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 24, 2020 at 1:10 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
> What is the rationale for this change, it may break other code.
>
> A common API model in Windows world where this originated
> is to have a call where caller first
> makes request and then if the requested buffer is not big enough the
> caller look at the actual length and allocate a bigger buffer.
>
> Did you audit all the users of this API to make sure they aren't doing that.
>

The rationale for the change was to solve instances like the one
@Haiyang Zhang pointed out, especially in hv_utils, which needs
additional hardening. Unfortunately, there is an instance in
hv_pci_onchannelcallback() that does what you just described. Thus,
the fix will have to be made to all the callers of vmbus_recvpacket()
and vmbus_recvpacket_raw() to make sure they check the return value,
which most callers are not doing now. Thanks for pointing out this
behavior. I was not aware that the length can be checked by callers to
allocate a bigger buffer.
