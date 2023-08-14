Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A30D77C049
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Aug 2023 21:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjHNTEV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Aug 2023 15:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHNTD7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Aug 2023 15:03:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EA1BC;
        Mon, 14 Aug 2023 12:03:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso27135355ad.1;
        Mon, 14 Aug 2023 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692039838; x=1692644638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECxt/EqUJaIlR0rP1Jf4J6URytJT1duQaMJUHBuym1I=;
        b=fXKDSFXPLHKOHEwCke9AXNpprKnF4DoqbU0mfX98RVt7UW9pq20YTtjofBIddrumnH
         mG9IgsOifr16HecyPGX+u0Xre3eg0Ok24NwgL/X1INVrwncdev3lufR6KUdpsJksYED+
         K4tTTFxS8sVDSaVGqgseWU+2xbVo7gxX9zZ3VOkik1u5/qkgd4+LGNW445TMMv2aO9lI
         lnESkVKcbxIy9zlL7B2qpUnOy9osYBvm1GzIpX0YPgFKkvKtegspSWzdIIDFg6ICYJhV
         NNtlUf3jyX/u6PFXTc3BQn9Gx7VvfZhHCacJ/F1kLi/pwmkFx6urSmKAp57SHlKtVFxl
         dc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039838; x=1692644638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECxt/EqUJaIlR0rP1Jf4J6URytJT1duQaMJUHBuym1I=;
        b=Mneh1F9KpJwaHBB7u4xyd1UxRitg8tBY3A018DVL+n+rcupbOgEgu7/f7S31CR+pPq
         S7SqPyWMovd6nKUqrqccHsmxuI9TbKMwlp63UhSc5Ya/+RBPU2uPwjFZtcNp4sT03aw3
         yDQph9gYToTfAbD+2Q9+aAIrh408h4Fenfww6I3bZtH7MVD0cR2Eaw9p4xrAKGDoyVxb
         KGD9Katvv8MEkUOjFRuiUtns2KmRXjfgawQWMdtmm8jyEtBeEoLVfqMlCnlRGLE2Q85S
         tuTbFQyGxc8Es0FqvWSwRJ5hZh091964E/ApfVOW8D57gW5VuascSyQZEGv+Wt5YsY/F
         B7og==
X-Gm-Message-State: AOJu0Yzx9goL2INHEmGFtlOCRCqqHNb0oXPxCQLUWUtCup6HKBPQi93x
        y6GvaMCoAa3bwRfI8YH6+yA=
X-Google-Smtp-Source: AGHT+IErs1aBD9w0HhOi+1Wck/MKk6Idh1gLlgbl9JnItBaUbYyOreYs9Z6BbRywbVN5mBqaOIgBLg==
X-Received: by 2002:a17:902:b58f:b0:1b9:f7f4:5687 with SMTP id a15-20020a170902b58f00b001b9f7f45687mr8321855pls.24.1692039838316;
        Mon, 14 Aug 2023 12:03:58 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001ab2b4105ddsm9805830plh.60.2023.08.14.12.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 12:03:57 -0700 (PDT)
Date:   Mon, 14 Aug 2023 12:03:55 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     x86@kernel.org, ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        wei.liu@kernel.org, Jason@zx2c4.com, nik.borisov@suse.com,
        mikelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com, isaku.yamahata@gmail.com
Subject: Re: [PATCH v10 1/2] x86/tdx: Retry partially-completed page
 conversion hypercalls
Message-ID: <20230814190355.GA2672897@ls.amr.corp.intel.com>
References: <20230811214826.9609-1-decui@microsoft.com>
 <20230811214826.9609-2-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811214826.9609-2-decui@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 11, 2023 at 02:48:25PM -0700,
Dexuan Cui <decui@microsoft.com> wrote:

> TDX guest memory is private by default and the VMM may not access it.
> However, in cases where the guest needs to share data with the VMM,
> the guest and the VMM can coordinate to make memory shared between
> them.
> 
> The guest side of this protocol includes the "MapGPA" hypercall.  This
> call takes a guest physical address range.  The hypercall spec (aka.
> the GHCI) says that the MapGPA call is allowed to return partial
> progress in mapping this range and indicate that fact with a special
> error code.  A guest that sees such partial progress is expected to
> retry the operation for the portion of the address range that was not
> completed.
> 
> Hyper-V does this partial completion dance when set_memory_decrypted()
> is called to "decrypt" swiotlb bounce buffers that can be up to 1GB
> in size.  It is evidently the only VMM that does this, which is why
> nobody noticed this until now.

Now TDX KVM + TDX qemu supports partial completion because TD guest can pass
very large range. e.g. 1GB order.  I tested this patch with (patched) TDX
KVM/qemu.

Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Tested-by: Isaku Yamahata <isaku.yamahata@intel.com>
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
