Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84D7CFE8E
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfJHQKH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 12:10:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39453 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfJHQKH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 12:10:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so20116293wrj.6;
        Tue, 08 Oct 2019 09:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TwO+d9qD9wJW979LKepMLImGrjMaBnzYxRK7KA5j0Xk=;
        b=aR/7iMpMxZ4g5vs+DrnV6pTeJm/kUw9rjmspB3P9tQeaRWxnUKOp7DaBbuWJcTp5+q
         aFKGK7Q2/J/v8a7pK6z7gYH2V0uSBFhA/TB3jEHix5FM5EGrTGPTI370DekIGEqKEDTi
         gVbc7MW/r0vdQIkRgnWMyUCQHdn6uG8LLCT8uyafThUL5eG+wPoqplsLCq3AsHWHKrv2
         1ix1h6hg19fo25wnJRokwQkarwa4WfwDh7JhOyG+Ncl4jrhWJi2KSZq2nE4RD3z8ShzF
         lD53o2vKVc41hlWqE8bIVUE8d0N6nIJ4qKIaSZWDmeDN4nQZ2qF2E56fA6eKUbq6PFKN
         2w/w==
X-Gm-Message-State: APjAAAVupkD3K0ZpYhZ4qHxq+5CakdwhzC9OXtWXCybXnnej1z7BQeT4
        EQzemptaO3xvJNUUTwRBcqE=
X-Google-Smtp-Source: APXvYqyLw49eump/ox38Z4zA11mDBtivQ61A7rJMxWU5H6pE4n+L8FeJt8/QHXENvF/U12TGXTn3sQ==
X-Received: by 2002:a5d:44d2:: with SMTP id z18mr6605539wrr.122.1570551003336;
        Tue, 08 Oct 2019 09:10:03 -0700 (PDT)
Received: from debian (207.148.159.143.dyn.plus.net. [143.159.148.207])
        by smtp.gmail.com with ESMTPSA id f20sm3302107wmb.6.2019.10.08.09.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 09:10:02 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:10:01 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux Kconfig List <linux-kbuild@vger.kernel.org>,
        Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH RFC] kconfig: add hvconfig for Linux on Hyper-V
Message-ID: <20191008161001.lwiduq4mlyjumw5b@debian>
References: <20191008131508.21189-1-liuw@liuw.name>
 <CAK7LNAQpszkwtp2mAfoPajkRi0SHPspivWn9sUsxO0oua2X6NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQpszkwtp2mAfoPajkRi0SHPspivWn9sUsxO0oua2X6NQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 09, 2019 at 01:03:19AM +0900, Masahiro Yamada wrote:
[...]
> > diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> > index ef2f2336c469..2ee46301b22e 100644
> > --- a/scripts/kconfig/Makefile
> > +++ b/scripts/kconfig/Makefile
> > @@ -104,6 +104,10 @@ PHONY += xenconfig
> >  xenconfig: xen.config
> >         @:
> >
> > +PHONY += hvconfig
> > +hvconfig: hv_guest.config
> > +       @:
> > +
> 
> 
> Does this need to be hooked up to kconfig Makefile?
> 

It is not strictly necessary. Just thought it would be nice to follow
existing examples.

> In my understanding, this code provides
> "make hvconfig" as a shorthand for "make hv_guest.config"
> 

Yes that's correct.

> Please do not do this.
> 
> 
> See "xenconfig" as a bad example.
> 
> "make xenconfig" is a shorthand of "make xen.config".
> This exists to save just one character typing.
> 
> 
> If I allow this, people would push more and more random pointless shorthands,
> which are essentially unrelated to kconfig.
> 
> 
> kvmconfig and xenconfig are just historical mistakes.
> 
> 
> Please drop the changes to scripts/kconfig/Makefile.

OK.

> 
> Also, please do not use misleading "kconfig:" for the subject prefix.
> You can use the subject prefix "hyper-v:" or something.
> 

OK.

Wei.
